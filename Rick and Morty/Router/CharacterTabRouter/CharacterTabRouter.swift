//
//  CharacterTabRouter.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import SwiftUI

enum CharacterTabRouter: Hashable {
   case CharacterDetailScreen(CharacterModel)
   case empty
}


extension CharacterTabRouter: View {
    var body: some View {
        switch self {
        case .CharacterDetailScreen(let CharacterModel):
            let viewModelDependencies = CharacterDetailViewModel.Dependencies()
            let viewModel = CharacterDetailViewModel(character: CharacterModel, dependencies: viewModelDependencies)
            CharacterView(viewModel: viewModel)
        case .empty:
            EmptyView()
        }
    }
}
