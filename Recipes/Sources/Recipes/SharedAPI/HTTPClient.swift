//
//  HTTPClient.swift
//
//
//  Created by sdykae on 10/26/23.
//

import Foundation

public protocol HTTPClientTask {
  func cancel()
}

public protocol HTTPClient {
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

  @discardableResult
  func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
}
