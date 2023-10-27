//
//  RecipesListViewModel.swift
//  RecipesNavigatorApp
//
//  Created by sdykae on 10/26/23.
//

import Combine
import Foundation
import Recipes

class RecipesListViewModel: ObservableObject {
  @Published var recipes = [Recipe]()
  @Published var filteredRecipes = [Recipe]()
  @Published var searchQuery = ""
  @Published var isLoading: Bool = false
  private var cancellables = Set<AnyCancellable>()

  private let httpClient: HTTPClient

  init(httpClient: HTTPClient) {
    self.httpClient = httpClient
    setUpSearchQueryListener()
  }

  private func setUpSearchQueryListener() {
    $searchQuery
      .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
      .removeDuplicates()
      .sink { [weak self] query in
        self?.applyFilter(query)
      }
      .store(in: &cancellables)
  }

  private func applyFilter(_ query: String) {
    if query.isEmpty {
      filteredRecipes = recipes
    } else {
      filteredRecipes = recipes.filter { recipe in
        recipe.name.localizedCaseInsensitiveContains(query) ||
          recipe.ingredients
          .contains(where: {
            $0.name.localizedCaseInsensitiveContains(query) || $0.type.localizedCaseInsensitiveContains(query)
          })
      }
    }
  }

  func fetchRecipes() {
    let url = URL(string: "https://demo7192285.mockable.io/recipes")!
    isLoading = true
    httpClient.get(from: url) { [weak self] result in
      defer {
        DispatchQueue.main.async {
          self?.isLoading = false
        }
      }
      switch result {
      case .success(let (data, response)):
        do {
          let recipes = try RecipesMapper.map(data, from: response)
          DispatchQueue.main.async {
            self?.recipes = recipes
            self?.applyFilter(self?.searchQuery ?? "")
          }
        } catch {
          // Handle error
        }
      case .failure:
        // Handle error
        break
      }
    }
  }
}
