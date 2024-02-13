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
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
        
//        switch task {
//        case .requestPlain:
//            return request
//        case let .requestSearchText(requestSearch):
//            guard
//                let data = try? JSONEncoder().encode(AnyEncodable(requestSearch)),
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            else {
//                return request
//            }
//
//            let stringParameters = json.compactMapValues(String.init(describing:))
//            if method == .GET {
//                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
//                urlComponents?.queryItems = stringParameters.map { URLQueryItem(name: $0, value: $1)}
//                request.url = urlComponents?.url
//            } else {
//                let urlParameters = stringParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
//                request.httpBody = urlParameters.data(using: .utf8)
//            }
//            return request
//        }
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
