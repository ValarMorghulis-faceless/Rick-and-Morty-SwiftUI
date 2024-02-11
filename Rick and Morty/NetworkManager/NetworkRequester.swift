//
//  NetworkRequester.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

public enum NetworkRequestError: Error {
    case error
}

public protocol NetworkRequester {
    func request(targetType: NetworkEndPoint) async throws -> Data
}
