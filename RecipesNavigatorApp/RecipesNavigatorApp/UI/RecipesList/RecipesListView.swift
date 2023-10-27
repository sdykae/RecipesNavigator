//
//  RecipesListView.swift
//  RecipesNavigatorApp
//
//  Created by sdykae on 10/26/23.
//

import Recipes
import SwiftUI

struct RecipesListView: View {
  @StateObject var viewModel = RecipesListViewModel(httpClient: URLSessionHTTPClient(session: URLSession.shared))

  @State private var selectedRecipe: Recipe?
  @State private var isShowingDetailSheet = false

  var body: some View {
    NavigationView {
      Group {
        if viewModel.isLoading {
          ProgressView("Loading recipes...")
        } else {
          mainContent
        }
      }
      .navigationTitle("Recipes")
      .searchable(text: $viewModel.searchQuery, prompt: "Search Recipes")
      .onAppear {
        viewModel.fetchRecipes()
      }
      .sheet(item: $selectedRecipe, onDismiss: {
        selectedRecipe = nil
      }) { recipe in
        NavigationView {
          RecipeDetailsView(viewModel: RecipeDetailsViewModel(
            httpClient: URLSessionHTTPClient(session: URLSession.shared),
            recipeId: recipe.id))
        }
      }
    }
  }

  @ViewBuilder
  private var mainContent: some View {
    if UIDevice.current.userInterfaceIdiom == .pad {
      recipesList
    } else {
      recipesList
    }
  }

  private var recipesList: some View {
    List(viewModel.filteredRecipes, id: \.id) { recipe in
      recipeButton(for: recipe)
    }
    .listStyle(.plain)
  }

  private func recipeButton(for recipe: Recipe) -> some View {
    Button(action: {
      selectedRecipe = recipe
    }) {
      HStack {
        AsyncImageView(
          placeholder: Image(systemName: "photo"),
          urlString: recipe.imageURL)
          .scaledToFill()
          .frame(width: 50, height: 50)
          .cornerRadius(25)
        Text(recipe.name)
          .font(.body)
          .lineLimit(1)
          .frame(
            maxWidth: .infinity,
            alignment: .leading)
        Spacer()
      }
      .contentShape(Rectangle())
      .padding(.vertical, 8)
    }
    .buttonStyle(.plain)
    .accentColor(.primary)
    .background(Color.clear)
  }
}
