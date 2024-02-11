//
//  CharacterModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import Foundation


public struct CharacterModel: Hashable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String?
    let gender: Gender
    let origin: Location
    let location: Location
    let image: URL
    let episodesUrl: URL
    let episode: [String]?
    let url: String?
    let created: String?
    let numberOfEpisodes: Int
    
    init(id: Int, name: String, status: Status, species: String, type: String, gender: Gender, origin: Location, location: Location, image: URL,episodesUrl: URL, episode: [String]?, url: String? = nil, created: String? = nil, numberOfEpisodes: Int) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episodesUrl =  episodesUrl
        self.episode = episode
        self.url = url
        self.created = created
        self.numberOfEpisodes = numberOfEpisodes
    }
}

public extension CharacterModel {
    enum Status: String, Hashable, CaseIterable {
        case alive, dead, unknown
    }
}

// MARK: - Status

public extension CharacterModel {
    enum Gender: String, Hashable, CaseIterable {
        case female, male, genderless, unknown
    }
}

// MARK: - Location

public extension CharacterModel {
    enum Location: Hashable {
        case known(name: String, url: String)
        case unknown
    }
}

public extension CharacterModel {
    static let mock = CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6)
}



public let mockCharacterList: [CharacterModel] = [
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),
    CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: "Asdasd"),
        location: .known(name: "Eart", url: "asdasdasd"),
        image: .mockimageurl, episodesUrl: URL(string: "asdasdasdasd")!,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6),

]
