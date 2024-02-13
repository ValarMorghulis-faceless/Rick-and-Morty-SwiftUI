//
//  CharacterDetailCoordinator.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

protocol CharacterDetailCoordinatorProtocol {
    func showEpisode(_ episode: EpisodeModel) -> AnyView
}

struct CharacterDetailCoordinator: CharacterDetailCoordinatorProtocol {
    private let dependencies: CharacterDetailModuleFactory.Dependencies
    
    init(dependencies: CharacterDetailModuleFactory.Dependencies) {
        self.dependencies = dependencies
    }
    func showEpisode(_ episode: EpisodeModel) -> AnyView {
        dependencies.episodeDetail(episode)
    }
}
