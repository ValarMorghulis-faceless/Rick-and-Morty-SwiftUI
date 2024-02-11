//
//  CharacterListView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

struct CharacterListView<ViewModel>: View where ViewModel: CharacterListViewModelType {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.verticalSizeClass) private var verticalSizeClass
   
    var body: some View {
    
        NavigationStack {
             stateMainView
                .navigationTitle("Characters")
            }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.input.onAppear()
        }
    }
}

private extension CharacterListView {
    @ViewBuilder
    var stateMainView: some View {
        switch viewModel.output.state {
        case .display:
            charactersGrid
        case let .showError(error):
            VStack(spacing: 6) {
                Text(error.title)
                    .font(.customFont(font: .montserratFont, style: .bold, size: .h0))
                Text(error.description)
            }
        }
    }
    
    var columns: [GridItem] {
        let numberOfColumns = 2
        return Array(repeating: GridItem(.flexible()), count: numberOfColumns)
    }
    
    var charactersGrid: some View {
        let characterList = viewModel.output.state.characterList
       return ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(characterList.data, id: \.id) { character in
                            
                            NavigationLink {
                                
                                makeDestination(for: character)
                        
                            } label: {
                                CharacterCellView(presentation: character)
                                                .padding(3)
                            }

                            
                        }

                    }
                    .padding()
                   
                }

            }
    }
    
    @ViewBuilder
    func makeDestination(for character: CharacterPresenter) -> some View {
        viewModel.input.showCharacter(character.model)
    }
    
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        let dependencies = CharacterListModuleFactory.Dependencies()
        return CharacterListModuleFactory(dependencies: dependencies).make()
    }
}


