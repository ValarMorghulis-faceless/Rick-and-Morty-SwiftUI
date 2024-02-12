//
//  CharacterListModuleFactory.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import SwiftUI


public struct CharacterListModuleFactory {
    let dependencies: Dependencies

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func make() -> some View {
        let coordinator = CharacterListCoordinator(dependencies: dependencies)
        let viewModel = CharacterListViewModel(coordinator: coordinator)
        return CharacterListView(viewModel: viewModel)
    }
}

public extension CharacterListModuleFactory {
    final class Dependencies {
        public typealias CharacterView = (CharacterModel) -> AnyView
        
        private(set) var characterDetail: CharacterView
        
        public init() {
            characterDetail = { _ in AnyView(EmptyView())}
        }
        
        public func configure(characterDetail: @escaping CharacterView) {
            self.characterDetail = characterDetail
        }
        
    }
}
