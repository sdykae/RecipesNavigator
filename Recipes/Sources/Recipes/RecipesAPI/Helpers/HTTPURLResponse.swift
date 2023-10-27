//
//  HTTPURLResponse.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Foundation

extension HTTPURLResponse {
  private static var OK_200: Int { 200 }

  var isOK: Bool {
    statusCode == HTTPURLResponse.OK_200
  }
}
