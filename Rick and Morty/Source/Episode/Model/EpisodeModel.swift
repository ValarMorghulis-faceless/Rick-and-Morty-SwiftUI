//
//  EpisodeModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

public struct EpisodeModel: Hashable {
    public let id: Int
    public let name: String
    public let airDate: String
    public let episode: String
    public let characterListUrl: URL
    public let numberOfCharacters: Int
    
}

public extension EpisodeModel {
    static let mock = EpisodeModel(id: 2, name: "Pilot", airDate: "Decembeer 2, 2013", episode: "S01E01", characterListUrl: .mockCharacterURL, numberOfCharacters: 8)
}

public struct EpisodeListInfo {
    public let episodes: [EpisodeModel]
    public let nextPageRequest: GetEpisodeListType?
    
    public init(episodes: [EpisodeModel], nextPageRequest: GetEpisodeListType?) {
        self.episodes = episodes
        self.nextPageRequest = nextPageRequest
    }
}

public extension EpisodeListInfo {
    var areMoreAvaliable: Bool {
        nextPageRequest != nil
    }
}
