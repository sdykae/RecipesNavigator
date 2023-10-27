//
//  RecipesAPIEndToEndTests.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Recipes
import XCTest

final class RecipesAPIEndToEndTests: XCTestCase {
  func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
    switch getFeedResult() {
    case let .success(recipes)?:
      XCTAssertEqual(recipes.count, 9, "Expected 8 images in the test account image feed")
      XCTAssertEqual(recipes[0].id, 0)
      XCTAssertEqual(recipes[1].id, 1)
      XCTAssertEqual(recipes[2].id, 2)
      XCTAssertEqual(recipes[3].id, 3)
      XCTAssertEqual(recipes[4].id, 4)
      XCTAssertEqual(recipes[5].id, 5)
      XCTAssertEqual(recipes[6].id, 6)
      XCTAssertEqual(recipes[7].id, 7)

    case let .failure(error)?:
      XCTFail("Expected successful feed result, got \(error) instead")

    default:
      XCTFail("Expected successful feed result, got no result instead")
    }
  }

  // MARK: - Helpers

  private func getFeedResult(file _: StaticString = #filePath, line _: UInt = #line) -> Swift
    .Result<[Recipe], Error>?
  {
    let client = ephemeralClient()
    let exp = expectation(description: "Wait for load completion")

    var receivedResult: Swift.Result<[Recipe], Error>?
    client.get(from: recipesTestServerURL) { result in
      receivedResult = result.flatMap { data, response in
        do {
          return try .success(RecipesMapper.map(data, from: response))
        } catch {
          return .failure(error)
        }
      }
      exp.fulfill()
    }
    wait(for: [exp], timeout: 5.0)

    return receivedResult
  }

  private var recipesTestServerURL: URL {
    URL(string: "https://demo7321057.mockable.io/recipes")!
  }

  private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    trackForMemoryLeaks(client, file: file, line: line)
    return client
  }
}
