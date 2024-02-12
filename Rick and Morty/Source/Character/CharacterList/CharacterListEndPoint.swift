//
//  CharacterListEndPoint.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

enum CharacterListEndpoint: NetworkEndPoint {
    case all
    //case filter(CharacterListRequestParameters)
    var baseURL: URL { RickAndMortyAPI.baseURL }
    var path: String { "character/"}
    var method: HTTPMethod { .GET }
    var task: RequestTask {
        switch self {
        case .all:
            return .requestPlain
        }
    }
    var headers: [String : String]? { nil }
}
