//
//  CharacterDetailFactory.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import SwiftUI

public struct CharacterDetailModuleFactory {
    
    public func make(character: CharacterModel) -> CharacterDetailViewModel {
        let viewModelDependencies = CharacterDetailViewModel.Dependencies()
        
        let viewModel = CharacterDetailViewModel(character: character, dependencies: viewModelDependencies)
        
        return viewModel
        
    }
}
