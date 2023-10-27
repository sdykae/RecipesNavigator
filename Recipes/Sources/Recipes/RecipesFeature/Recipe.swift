//
//  Recipe.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Foundation

public struct Recipe: Equatable, Identifiable {
  public init(id: Int, name: String, imageURL: String, ingredients: [Ingredient]) {
    self.id = id
    self.name = name
    self.imageURL = imageURL
    self.ingredients = ingredients
  }

  public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
    lhs.id == rhs.id
  }

  public let id: Int
  public let name: String
  public let imageURL: String
  public let ingredients: [Ingredient]
}

public struct Ingredient: Equatable {
  public let name: String
  public let type: String
  public init(name: String, type: String) {
    self.name = name
    self.type = type
  }
}
