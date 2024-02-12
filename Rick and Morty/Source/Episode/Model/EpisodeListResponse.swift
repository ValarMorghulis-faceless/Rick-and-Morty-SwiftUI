//
//  EpisodeListResponse.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

struct EpisodeListResponse: Decodable {
    let info: Info
    let results: [EpisodeResult]
}

extension EpisodeListResponse {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}

extension EpisodeListResponse {
    struct EpisodeResult: Decodable {
        let id: Int
        let name: String
        let airDate: String
        let episode: String
        let characters: [URL]
        let url: String
        let created: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case airDate = "air_date"
            case episode
            case characters
            case url
            case created
        }
    }
}
