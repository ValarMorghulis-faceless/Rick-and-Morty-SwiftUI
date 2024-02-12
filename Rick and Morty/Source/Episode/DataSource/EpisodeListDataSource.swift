//
//  EpisodeListDataSource.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

typealias EpisodeListDataResult = Result<EpisodeListResponse, EpisodeListDataSourceError>

enum EpisodeListDataSourceError: Error {
    case unableToDecode
    case custom(Error)
}

protocol EpisodeListDataSource {
    func retrieve() async -> EpisodeListDataResult
    func retrieve(url: URL) async -> EpisodeListDataResult
    func retrieve(parametres: EpisodeListRequestParameters) async -> EpisodeListDataResult
}

struct EpisodeListRequestParameters: Encodable {
    let name: String
}
