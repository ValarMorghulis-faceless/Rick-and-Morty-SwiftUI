//
//  NetworkEndPoint.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

public protocol NetworkEndPoint{
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: RequestTask { get }
    var headers: [String: String]? { get }
}

public enum RequestTask {
    case requestPlain
    case requestSearchText(requestSearch: String)
}

public enum HTTPMethod: String {
    case CONNECT = "CONNECT"
    case DELETE = "DELETE"
    case GET = "GET"
    case HEAD = "HEAD"
    case OPTIONS = "OPTIONS"
    case PATCH = "PATCH"
    case POST = "POST"
    case PUT = "PUT"
    case trace = "TRACE"
}

public struct URLNetworkTargetType: NetworkEndPoint {
    public let baseURL: URL
    public let path = ""
    public let method = HTTPMethod.GET
    public let task = RequestTask.requestPlain
    public let headers: [String: String]? = nil
    
    public init(url: URL) {
        baseURL = url
    }
}
