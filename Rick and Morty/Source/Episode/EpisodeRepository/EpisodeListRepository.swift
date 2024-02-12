//
//  EpisodeListRepository.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

struct EpisodesInfo {
    let paginationURL: URL?
}

struct EpisodeList {
    let elements: [EpisodeModel]
    let info: EpisodesInfo
}

typealias EpisodeListResult = Result<EpisodeList, EpisodeListRepositoryError>


enum EpisodeListRepositoryError: Error {
    case unableToDecode
    case dataSource(Error)
}

protocol EpisodeListRepository {
    func retrieve() async -> EpisodeListResult
    func retrieve(url: URL) async -> EpisodeListResult
}
