//
//  EpisodeListNavigator.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

protocol EpisodeListCoordinatorProtocol {
    func showEpisode(_ episode: EpisodeModel) -> AnyView
}

struct EpisodeListCoordinator: EpisodeListCoordinatorProtocol {
    private let dependencies: EpisodeListModuleFactory.Dependencies
    
    init(dependencies: EpisodeListModuleFactory.Dependencies) {
        self.dependencies = dependencies
    }
    func showEpisode(_ episode: EpisodeModel) -> AnyView {
        dependencies.episodeDetail(episode)
    }
}
