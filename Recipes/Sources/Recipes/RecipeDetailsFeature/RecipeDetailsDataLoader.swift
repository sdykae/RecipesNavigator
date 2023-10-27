//
//  RecipeDetailsDataLoader.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Foundation

public protocol RecipeDetailsDataLoader {
  func loadRecipeDetailsData(from url: URL) throws -> RecipeDetails
}
