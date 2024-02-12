//
//  CharacterViewMapper.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

protocol CharacterDetailViewMapper {
    func map(from character: CharacterModel) -> CharacterDetailPresenter
    func map(from listInfo: EpisodeListInfo, for presenter: CharacterDetailPresenter) -> CharacterDetailPresenter
}

struct DefaultCharacterDetailViewMapper: CharacterDetailViewMapper {
    func map(from listInfo: EpisodeListInfo, for presenter: CharacterDetailPresenter) -> CharacterDetailPresenter {
        let episodes = listInfo.episodes.map { episode in
            CharacterDetailPresenter.EpisodePresenterData(title: "\(episode.episode) · \(episode.name)", airDate: episode.airDate, model: episode)
        }
        return CharacterDetailPresenter(image: presenter.image, name: presenter.name, sections: presenter.sections, episodesSectionTitle: presenter.episodesSectionTitle, episodes: .data(episodes))
    }
    
    func map(from character: CharacterModel) -> CharacterDetailPresenter {
        let sections = [
            makeGeneralInfoSection(from: character),
            makeLocationInfoSection(from: character)
        ]
        return CharacterDetailPresenter(image: character.image, name: character.name, sections: sections, episodesSectionTitle: makeEpisodesSectionTitle(from: character), episodes: .placeholder(numberOfItems: character.numberOfEpisodes))
    }
    private func makeGeneralInfoSection(from character: CharacterModel) -> CharacterDetailPresenter.InfoSection {
        var  infoRows: [CharacterDetailPresenter.InfoRow] = [
            .init(emojiIcon:character.status.icon , title: "Status", value: character.status.rawValue.capitalizedFirstLetter(), statusColor: character.status.statusColor),
            .init(emojiIcon: "🧬", title: "Specie", value: character.species, statusColor: nil),
            .init(emojiIcon: character.gender.genderIcon, title: "Gender", value: character.gender.rawValue.capitalizedFirstLetter(), statusColor: nil)
        ]
        if let type = character.type, !type.isEmpty {
            infoRows.append(.init(emojiIcon: "🌱", title: "Type", value: type.capitalizedFirstLetter(), statusColor: nil))
        }
        return .init(title: "Info", rows: infoRows)
    }
    private func makeLocationInfoSection(from character: CharacterModel) -> CharacterDetailPresenter.InfoSection {
        let infoRows: [CharacterDetailPresenter.InfoRow] = [
            .init(emojiIcon: "📍", title: "First seen in:", value: character.origin.name, statusColor: nil),
            .init(emojiIcon: "🗺", title: "Last known location:", value: character.location.name, statusColor: nil)
        ]
        
        return .init(title: "Location", rows: infoRows)
    }
    
    private func makeEpisodesSectionTitle(from character: CharacterModel) -> String {
        if character.numberOfEpisodes == 1 {
            return "Episode"
        } else {
            return "Episodes (\(character.numberOfEpisodes)"
        }
    }
}

private extension CharacterModel.Status {
    var icon: String {
        switch self {
        case .alive: return "✅"
        case .dead: return "⚰️"
        case .unknown: return "❓"
        }
    }
}

private extension CharacterModel.Gender {
    var genderIcon: String {
        switch self {
        case .male: return "🙍‍♂️"
        case .female: return "🙎‍♀️"
        case .unknown: return "👽"
        case .genderless: return "🪱"
        }
    }
}

public extension CharacterModel.Status {
    var statusColor: String {
        switch self {
        case .alive: return "Green"
        case .dead: return "Red"
        case .unknown: return "Yellow"
        }
    }
}

public extension CharacterModel.Location {
    var name: String {
        switch self {
        case let .known(name, _):
            return name
        case .unknown:
            return "Unknown"
        }
    }
}
