//
//  CharacterDetailFactory.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import SwiftUI

public struct CharacterDetailModuleFactory {
    
    let dependencies: Dependencies
    
    public func make(character: CharacterModel) -> some View {
        let viewModelDependencies = CharacterDetailViewModel.Dependencies(getEpisodeList: dependencies.getEpisodeList)
        
        let viewModel = CharacterDetailViewModel(character: character, dependencies: viewModelDependencies)
        
        return CharacterView(viewModel: viewModel)
        
    }
}

public extension CharacterDetailModuleFactory {
    final class Dependencies {
        public typealias EpisodeDetailScreen = (EpisodeModel) -> AnyView
        private(set) var episodeDetail: EpisodeDetailScreen = { _ in AnyView(EmptyView())}
        let getEpisodeList: GetEpisodeListUseCase
        public init(getEpisodeList: GetEpisodeListUseCase) {
            self.getEpisodeList = getEpisodeList
        }
        public func configure(episodeDetail: @escaping EpisodeDetailScreen) {
            self.episodeDetail = episodeDetail
        }
    }
}
