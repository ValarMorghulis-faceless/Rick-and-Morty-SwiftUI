//
//  EpisodeListModuleFactory.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

public struct EpisodeListModuleFactory {
    let dependencies: Dependencies
    public let useCases = UseCases()
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
//    public func make() -> some View {
//     //   let navigator = EpisodeListNavigator(dependencies: dependencies)
//        let viewModel = EpisodeListViewModel(dependencies: dependencies)
//        return EpisodeListView(viewModel: viewModel)
//    }

    
}


public extension EpisodeListModuleFactory {
    final class Dependencies {
        private(set) var episodeDetail: (EpisodeModel) -> AnyView
        
        public init() {
            episodeDetail = { _ in AnyView(EmptyView())}
        }
        
        public func configure(episodeDetail: @escaping (EpisodeModel) -> AnyView) {
            self.episodeDetail = episodeDetail
        }
        
    }
}

public extension EpisodeListModuleFactory {
    struct UseCases {
        public let getEpisodeList: GetEpisodeListUseCase = GetEpisodeList()
    }
}
