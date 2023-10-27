//
//  RecipeDetailsViewModel.swift
//  RecipesNavigatorApp
//
//  Created by sdykae on 10/26/23.
//

import Combine
import Foundation
import Recipes

class RecipeDetailsViewModel: ObservableObject {
  @Published var recipeDetails: RecipeDetails?
  @Published var isLoading = false

  private let httpClient: HTTPClient
  private let recipeId: Int
  private var cancellables = Set<AnyCancellable>()

  init(httpClient: HTTPClient, recipeId: Int) {
    self.httpClient = httpClient
    self.recipeId = recipeId
  }

  func fetchRecipeDetails() {
    guard !isLoading else { return }
    isLoading = true
    let url = URL(string: "https://demo7192285.mockable.io/recipe?id=\(recipeId)")!
    httpClient.get(from: url) { [weak self] result in
      defer {
        DispatchQueue.main.async {
          self?.isLoading = false
        }
      }
      switch result {
      case .success(let (data, response)):
        do {
          let recipeDetails = try RecipeDetailsMapper.map(data, from: response)
          DispatchQueue.main.async {
            self?.recipeDetails = recipeDetails
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
