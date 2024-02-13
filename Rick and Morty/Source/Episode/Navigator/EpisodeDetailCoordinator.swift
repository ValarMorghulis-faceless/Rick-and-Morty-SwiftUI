//
//  EpisodeDetailCoordinator.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

protocol EpisodeDetailCoordinatorProtocol {
    func showCharacter(_ character: CharacterModel) -> AnyView
}

struct EpisodeDetailNavigator: EpisodeDetailCoordinatorProtocol {
    private let dependencies: EpisodeDetailModuleFactory.Dependencies
    
    init(dependencies: EpisodeDetailModuleFactory.Dependencies) {
        self.dependencies = dependencies
    }
    
    func showCharacter(_ character: CharacterModel) -> AnyView {
        dependencies.characterDetail(character)
    }
}
