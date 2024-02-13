//
//  EpisodeDetailViewMapper.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

protocol EpisodeDetailViewMapper {
    func map(from episode: EpisodeModel) -> EpisodeDetailPresenter
    func map(from listInfo: CharacterListInfo, for presentation: EpisodeDetailPresenter) -> EpisodeDetailPresenter
}

struct DefaultEpisodeDetailViewMapper: EpisodeDetailViewMapper {
    
    func map(from episode: EpisodeModel) -> EpisodeDetailPresenter {
        let sections = [makeGeneralInfoSection(from: episode)]
        return EpisodeDetailPresenter(name: episode.name, sections: sections, characters: .placeholder(numberOfItems: episode.numberOfCharacters))
    }
    
    func map(from listInfo: CharacterListInfo, for presentation: EpisodeDetailPresenter) -> EpisodeDetailPresenter {
        let characters = listInfo.characters.map { character in
            EpisodeDetailPresenter.CharacterPresenterData(image: character.image, name: character.name, model: character)
        }
        return EpisodeDetailPresenter(name: presentation.name, sections: presentation.sections, characters: .data(characters))
    }
    
    private func makeGeneralInfoSection(from episode: EpisodeModel) -> EpisodeDetailPresenter.EpisodeSection {
        let infoRows: [EpisodeDetailPresenter.InfoRow] = [
            .init(emojiIcon: "tv", title: "Episode", value: episode.episode),
            .init(emojiIcon: "calendar", title: "Air date", value: episode.airDate)
        ]
        return .init(title: "Info", rows: infoRows)
    }
    
}
