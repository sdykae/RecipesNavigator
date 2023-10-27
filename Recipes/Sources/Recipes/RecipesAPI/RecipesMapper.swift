//
//  RecipesMapper.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Foundation

public enum RecipesMapper {
  private struct Root: Decodable {
    private let items: [RemoteRecipe]

    struct RemoteRecipe: Decodable {
      let id: Int
      let name: String
      let imageURL: String
      let ingredients: [RemoteIngredient]

      var recipe: Recipe {
        Recipe(
          id: id,
          name: name,
          imageURL: imageURL,
          ingredients: ingredients.map { Ingredient(name: $0.name, type: $0.type) })
      }
    }

    var recipes: [Recipe] {
      items.map { $0.recipe }
    }

    struct RemoteIngredient: Decodable {
      let name: String
      let type: String
    }
  }

  public enum Error: Swift.Error {
    case invalidData
  }

  public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Recipe] {
    guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
      throw Error.invalidData
    }

    return root.recipes
  }
}
