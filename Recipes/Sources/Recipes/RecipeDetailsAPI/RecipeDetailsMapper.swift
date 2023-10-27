//
//  RecipeDetailsMapper.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Combine
import Foundation

public enum RecipeDetailsMapper {
  private struct RemoteRecipeDetails: Decodable {
    let id: Int
    let name: String
    let ingredients: [RemoteIngredient]
    let steps: [String]
    let timers: [Int]
    let imageURL: String
    let originalURL: String
    let location: RemoteLocation

    var details: RecipeDetails {
      RecipeDetails(
        id: id,
        name: name,
        ingredients: ingredients.map(\.ingredient),
        steps: steps,
        timers: timers,
        imageURL: imageURL,
        originalURL: originalURL,
        location: location.location)
    }

    struct RemoteIngredient: Decodable {
      let quantity: String
      let name: String
      let type: String

      var ingredient: RecipeDetails.DetailedIngredient {
        .init(quantity: quantity, name: name, type: type)
      }
    }

    struct RemoteLocation: Decodable {
      let latitude: Double
      let longitude: Double

      var location: RecipeDetails.Location {
        .init(latitude: latitude, longitude: longitude)
      }
    }
  }

  public enum Error: Swift.Error {
    case invalidData
  }

  public static func map(_ data: Data, from response: HTTPURLResponse) throws -> RecipeDetails {
    guard response.isOK, let root = try? JSONDecoder().decode(RemoteRecipeDetails.self, from: data) else {
      throw Error.invalidData
    }
    return root.details
  }
}
