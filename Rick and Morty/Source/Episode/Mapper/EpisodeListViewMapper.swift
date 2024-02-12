//
//  EpisodeListViewMapper.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

protocol EpisodeListViewMapper {
    func map(from listInfo: EpisodeListInfo, shouldReload: Bool) -> EpisodeListPresenter
    func map(from error: GetEpisodeListError) -> EpisodeListError
}

struct DefaultEpisodeListViewMapper: EpisodeListViewMapper {
    
    func map(from listInfo: EpisodeListInfo, shouldReload: Bool) -> EpisodeListPresenter {
        let episodes = listInfo.episodes.map {
            EpisodePresenter(title: "\($0.episode) | \($0.name)", airDate: $0.airDate, model: $0)
        }
        let episodeListPresenter = EpisodeListPresenter.data(episodes: episodes, hasMore: listInfo.areMoreAvaliable)
        return episodeListPresenter
    }
    
    func map(from error: GetEpisodeListError) -> EpisodeListError {
        switch error {
        case .unableToGetList:
            return EpisodeListError(title: "HELLL NO", description: "There are no episodes right now")
        }
    }
   
}
