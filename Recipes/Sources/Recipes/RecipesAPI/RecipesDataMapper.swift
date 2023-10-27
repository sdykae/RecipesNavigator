//
//  RecipesDataMapper.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Foundation

public enum RecipesDataMapper {
  public enum Error: Swift.Error {
    case invalidData
  }

  public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
    guard response.isOK, !data.isEmpty else {
      throw Error.invalidData
    }
    return data
  }
}
