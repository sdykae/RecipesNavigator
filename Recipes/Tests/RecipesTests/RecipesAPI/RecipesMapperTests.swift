//
//  RecipesMapperTests.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Recipes
import XCTest

final class RecipesMapperTests: XCTestCase {
  func test_map_throwsErrorOnNon200HTTPResponse() throws {
    let json = makeItemsJSON([])
    let samples = [199, 201, 300, 400, 500]

    try samples.forEach { code in
      XCTAssertThrowsError(
        try RecipesMapper.map(json, from: HTTPURLResponse(statusCode: code)))
    }
  }

  func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
    let invalidJSON = Data("invalid json".utf8)

    XCTAssertThrowsError(
      try RecipesMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200)))
  }

  func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
    let emptyListJSON = makeItemsJSON([])

    let result = try RecipesMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))

    XCTAssertEqual(result, [])
  }

  func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
    let ingredient1 = Ingredient(name: "Sugar", type: "Condiment")
    let ingredient2 = Ingredient(name: "Salt", type: "Condiment")

    let recipe1 = makeItem(
      id: 1,
      name: "A Recipe",
      imageURL: "http://a-url.com",
      ingredients: [ingredient1])

    let recipe2 = makeItem(
      id: 2,
      name: "Another Recipe",
      imageURL: "http://another-url.com",
      ingredients: [ingredient1, ingredient2])

    let json = makeItemsJSON([recipe1.json, recipe2.json])

    let result = try RecipesMapper.map(json, from: HTTPURLResponse(statusCode: 200))

    XCTAssertEqual(result, [recipe1.model, recipe2.model])
  }

  // MARK: - Helpers

  private func makeItem(
    id: Int,
    name: String,
    imageURL: String,
    ingredients: [Ingredient]) -> (model: Recipe, json: [String: Any])
  {
    let item = Recipe(id: id, name: name, imageURL: imageURL, ingredients: ingredients)

    var ingredientsJSONArray = [[String: String]]()
    for ingredient in ingredients {
      ingredientsJSONArray.append(["name": ingredient.name, "type": ingredient.type])
    }

    let json: [String: Any] = [
      "id": id,
      "name": name,
      "imageURL": imageURL,
      "ingredients": ingredientsJSONArray,
    ]

    return (item, json)
  }
}
