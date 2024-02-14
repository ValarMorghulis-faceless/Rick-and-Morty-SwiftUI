//
//  NetworkTarget.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

extension NetworkEndPoint {
    var urlRequest: URLRequest {
        var url = baseURL.appendingPathComponent(path)
        switch task {
        case let .requestSearchText(requestSearch):
            url.append(queryItems: [URLQueryItem(name: "name", value: requestSearch)])
        default:
            break
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
}


private struct AnyEncodable: Encodable {
    var _encodeFunc: (Encoder) throws -> Void
    
    init(_ encodable: Encodable) {
        func _encode(to encoder: Encoder) throws {
            try encodable.encode(to: encoder)
        }
        _encodeFunc = _encode
    }
    func encode(to encoder: Encoder) throws {
        try _encodeFunc(encoder)
    }
}
