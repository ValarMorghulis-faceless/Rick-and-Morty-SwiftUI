//
//  EpisodeListMapper.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

protocol EpisodeListMapper {
    func map(response: EpisodeListResponse) -> EpisodeList
    func map(error: EpisodeListDataSourceError) -> EpisodeListRepositoryError
}

struct DefaultEpisodeListMapper: EpisodeListMapper {
    struct Error: Swift.Error {
        let description: String
    }
    func map(response: EpisodeListResponse) -> EpisodeList {
        let episodes = try? response.results.map { result in
            EpisodeModel(id: result.id, name: result.name, airDate: result.airDate, episode: result.episode, characterListUrl: try makeCharacterListUrlsFrom(urls: result.characters), numberOfCharacters: result.characters.count)
        }
        let nextUrl = response.info.next ?? ""
        let episodesInfo = EpisodesInfo(paginationURL: try? URL(with: nextUrl))
        let list = EpisodeList(elements: episodes ?? [], info: episodesInfo)
        return list
    }
    
    func map(error: EpisodeListDataSourceError) -> EpisodeListRepositoryError {
        switch error {
        case .unableToDecode:
            return .unableToDecode
        case let .custom(dataSourceError):
            return .dataSource(dataSourceError)
        }
    }
    
    private func makeCharacterListUrlsFrom(urls: [URL]) throws -> URL {
        guard let baseUrl = urls.first?.deletingLastPathComponent() else {
            throw DefaultEpisodeListMapper.Error(description: "Cannot decode base URL")
        }
        let joinedPathComponents = urls.map { $0.lastPathComponent }.joined(separator: ",")
        return baseUrl.appendingPathComponent(joinedPathComponents)
    }
}

private extension URL {
    init(with url: String) throws {
        if let url = URL(string: url) {
            self = url
        } else {
            throw DefaultEpisodeListMapper.Error(description: "Cannot decode \(url)")
        }
    }
}
