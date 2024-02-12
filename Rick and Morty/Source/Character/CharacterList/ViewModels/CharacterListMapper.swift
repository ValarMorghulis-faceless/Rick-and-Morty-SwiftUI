//
//  CharacterListMapper.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

protocol CharacterListMapper {
    func map(response: CharacterListResponse) -> CharacterList
    func map(error: CharacterListDataSourceError) -> CharacterListRepositoryError
}

struct DefaultCharacterListMapper: CharacterListMapper {
    
    struct Error: Swift.Error {
        let description: String
    }
    func map(response: CharacterListResponse) -> CharacterList {
        let characters = try? response.results.compactMap { result -> CharacterModel in
            let characterEpisodes = result.episode.compactMap(URL.init(string:))
            guard let episodePath = characterEpisodes.first?.deletingLastPathComponent() else {
                throw Error(description: "There will always be more episodes")
            }
            let episodesPathComponents = characterEpisodes.map(\.lastPathComponent).joined(separator: ",")
            let episodesUrl = episodePath.appending(component: episodesPathComponents)
            return CharacterModel(id: result.id, name: result.name, status: try .init(status: result.status), species: result.species, type: result.type.isEmpty ? "" : result.type, gender: try .init(gender: result.gender), origin: try .init(location: result.origin), location: try .init(location: result.location), image: try .init(with: result.image), episodesUrl: episodesUrl, episode: nil, numberOfEpisodes: result.episode.count)
            
        }
        let nextUrl = response.info.next ?? ""
        let charactersInfo = CharactersInfo(paginationURL: try? URL(with: nextUrl))
        let list = CharacterList(elements: characters ?? [], info: charactersInfo)
        return list
    }
    
    func map(error: CharacterListDataSourceError) -> CharacterListRepositoryError {
        switch error {
        case .unableToDecode:
            return .unableToDecode
        case let .custom(dataSourceError):
            return .dataSource(dataSourceError)
        }
    }
}


private extension CharacterModel.Status {
    init(status: CharacterListResponse.ListResult.Status) throws {
        if let status = CharacterModel.Status(rawValue: status.rawValue.lowercased()) {
            self = status
        } else {
            throw DefaultCharacterListMapper.Error(description: "Cannot decode \(status.rawValue)")
        }
    }
}

private extension CharacterModel.Gender {
    init(gender: CharacterListResponse.ListResult.Gender) throws {
        if let gender = CharacterModel.Gender(rawValue: gender.rawValue.lowercased()) {
            self = gender
        } else {
            throw DefaultCharacterListMapper.Error(description: "Cannot decode \(gender.rawValue)")
        }
    }
}

private extension CharacterModel.Location {
    init(location: CharacterListResponse.ListResult.Location) throws {
        if !location.name.isEmpty {
            if !location.url.isEmpty {
                self = .known(name: location.name, url: location.url)
            } else {
                self = .unknown
            }
        } else {
            throw DefaultCharacterListMapper.Error(description: "Cannot decode \(location.name)")
        }
    }
}

private extension URL {
    init(with url: String) throws {
        if let url = URL(string: url) {
            self = url
        } else {
            throw DefaultCharacterListMapper.Error(description: "Cannot decode \(url)")
        }
    }
}
