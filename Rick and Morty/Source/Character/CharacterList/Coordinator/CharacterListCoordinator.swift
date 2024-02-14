//
//  CharacterListCoordinator.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import SwiftUI

protocol CharacterListCoordinatorProtocol {
    func showCharacter(_ character: CharacterModel) -> AnyView
}

struct CharacterListCoordinator: CharacterListCoordinatorProtocol {
    private let dependencies: CharacterListModuleFactory.Dependencies
    
    init(dependencies: CharacterListModuleFactory.Dependencies) {
        self.dependencies = dependencies
    }
    
    func showCharacter(_ character: CharacterModel) -> AnyView {
        dependencies.characterDetail(character)
    }
}
