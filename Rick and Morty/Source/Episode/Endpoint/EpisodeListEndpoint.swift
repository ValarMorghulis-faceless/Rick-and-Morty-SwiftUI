//
//  EpisodeListEndpoint.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

enum EpisodeListNetworkTargetType: NetworkEndPoint {
    case all
    case filter(EpisodeListRequestParameters)
    
    var baseURL: URL { RickAndMortyAPI.baseURL }
    var path: String { "episode/"}
    var method: HTTPMethod { .GET }
    var task: RequestTask {
        switch self {
        case .all:
            return .requestPlain
        case let .filter(parametres):
            return .request(parameters: parametres)
        }
    }
    
    var headers: [String: String]? { nil }
    
}
