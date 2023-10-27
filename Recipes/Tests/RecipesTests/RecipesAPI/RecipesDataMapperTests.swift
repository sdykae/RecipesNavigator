//
//  RecipesDataMapperTests.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Recipes
import XCTest

final class RecipesDataMapperTests: XCTestCase {
  func test_map_throwsErrorOnNon200HTTPResponse() throws {
    let samples = [199, 201, 300, 400, 500]

    try samples.forEach { code in
      XCTAssertThrowsError(
        try RecipesDataMapper.map(anyData(), from: HTTPURLResponse(statusCode: code)))
    }
  }

  func test_map_deliversInvalidDataErrorOn200HTTPResponseWithEmptyData() {
    let emptyData = Data()

    XCTAssertThrowsError(
      try RecipesDataMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200)))
  }

  func test_map_deliversReceivedNonEmptyDataOn200HTTPResponse() throws {
    let nonEmptyData = Data("non-empty data".utf8)

    let result = try RecipesDataMapper.map(nonEmptyData, from: HTTPURLResponse(statusCode: 200))

    XCTAssertEqual(result, nonEmptyData)
  }
}
