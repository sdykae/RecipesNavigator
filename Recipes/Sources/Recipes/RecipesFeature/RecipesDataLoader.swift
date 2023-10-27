//
//  RecipesDataLoader.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Foundation

public protocol RecipesDataLoader {
  func loadRecipesData(from url: URL) throws -> Data
}
