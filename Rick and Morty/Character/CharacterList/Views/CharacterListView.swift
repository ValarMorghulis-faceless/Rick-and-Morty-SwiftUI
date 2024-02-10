//
//  CharacterListView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

struct CharacterListView<ViewModel>: View where ViewModel: CharacterListViewModelType {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var router: Router
    var columns: [GridItem] {
        let numberOfColumns = 2
        return Array(repeating: GridItem(.flexible()), count: numberOfColumns)
    }
    var body: some View {
        let characterList = viewModel.output.state.characterList
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(characterList.data, id: \.id) { character in
                        
                        Button {
                            router.navigateTo(type: CharacterTabRouter.CharacterDetailScreen(character.model))
                        } label: {
                            CharacterCellView(presentation: character)
                        }
                        
                    }
                }
                .onAppear {
                    viewModel.input.onAppear()
                }
                
            }
            
        }
        
        
        
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static let viewModel = CharacterListViewModel()
    static var previews: some View {
        CharacterListView(viewModel: viewModel)
    }
}
