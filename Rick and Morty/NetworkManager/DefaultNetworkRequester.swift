//
//  DefaultNetworkRequester.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

struct DefaultNetworkRequester: NetworkRequester {
    private enum HTTPStatusCode {
        static let successfulRange = 200 ..< 300
    }
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    func request(targetType: NetworkEndPoint) async throws -> Data {
        let request = targetType.urlRequest
        guard
            let (data, response) = try? await session.data(for: request, delegate: nil),
            let urlResponse = response as? HTTPURLResponse
        else {
            throw NetworkRequestError.error
        }
        
        guard HTTPStatusCode.successfulRange ~= urlResponse.statusCode else {
            throw NetworkRequestError.error
        }
        
        return data
    }
}

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    
}
