//
//  DependenciesResolver.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import SwiftUI

protocol ResolverProtocol {
    var characterListFactory: CharacterListModuleFactory { get }
    var episodeListFactory: EpisodeListModuleFactory { get }
}

struct DependenciesResolver: ResolverProtocol {
    let characterListFactory: CharacterListModuleFactory
    let episodeListFactory: EpisodeListModuleFactory
    init() {
        let episodeListDependencies = EpisodeListModuleFactory.Dependencies()
        episodeListFactory = EpisodeListModuleFactory(dependencies: episodeListDependencies)
        let characterDetailDependencies = CharacterDetailModuleFactory.Dependencies(getEpisodeList: episodeListFactory.useCases.getEpisodeList)
        let characterDetailFactory = CharacterDetailModuleFactory(dependencies: characterDetailDependencies)
        let characterLitDependencies = CharacterListModuleFactory.Dependencies()
        characterLitDependencies.configure { character in
            AnyView(characterDetailFactory.make(character: character))
        }
        characterListFactory = CharacterListModuleFactory(dependencies: characterLitDependencies)
        let episodeDetailDependencies = EpisodeDetailModuleFactory.Dependencies(getCharacterList: characterListFactory.useCases.getCharacterList)
        let episodeDetailFactory = EpisodeDetailModuleFactory(dependencies: episodeDetailDependencies)
        
        characterDetailDependencies.configure { episode -> AnyView in
            AnyView(episodeDetailFactory.make(episode: episode))
        }
        
    }
    
}
