//
//  EpisodeListInfoMapper.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

protocol EpisodeListInfoMapper {
    func map(response: EpisodeList) -> EpisodeListInfo
    func map(erro: EpisodeListRepositoryError) -> GetEpisodeListError
}

struct DefaultEpisodeListInfoMapper: EpisodeListInfoMapper {
    func map(response: EpisodeList) -> EpisodeListInfo {
        EpisodeListInfo(episodes: response.elements, nextPageRequest: response.info.paginationURL.map(GetEpisodeListType.url))
    }
    func map(erro: EpisodeListRepositoryError) -> GetEpisodeListError {
        .unableToGetList
    }
}
