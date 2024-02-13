//
//  EpisodeDetailModuleFactory.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

public struct EpisodeDetailModuleFactory {
    let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func make(episode: EpisodeModel) -> some View {
        let coordinator = EpisodeDetailNavigator(dependencies: dependencies)
        let viewModelDependencies = EpisodeDetailViewModel.Dependencies(getCharacterList: dependencies.getCharacterList)
        let viewModel = EpisodeDetailViewModel(episode: episode, coordinator: coordinator, dependencies: viewModelDependencies)
        return EpisodeDetailView(viewModel: viewModel)
        
    }
    
}

public extension EpisodeDetailModuleFactory {
    final class Dependencies {
        public typealias CharacterDetailScreen = (CharacterModel) -> AnyView
        
        private(set) var characterDetail: CharacterDetailScreen = { _ in AnyView(EmptyView())}
        
        let getCharacterList: GetCharacterListUseCase
        
        public init(getCharacterList: GetCharacterListUseCase) {
            self.getCharacterList = getCharacterList
        }
        
        public func configure(characterDetail: @escaping CharacterDetailScreen) {
            self.characterDetail = characterDetail
        }
        
    }
}
