//
//  EpisodeDetailView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

struct EpisodeDetailView<ViewModel>: View where ViewModel: EpisodeDetailViewModelType {
    @StateObject var viewModel: ViewModel
    var rows: [GridItem] {
        let numberOfrows = 1
        return Array(repeating: GridItem(.flexible()), count: numberOfrows)
    }
    var body: some View {
        let presenter = viewModel.output.state
        
        VStack {
 
                ForEach(presenter.sections, id: \.self) { section in
                    
                    VStack(alignment: .leading) {
                        Text(section.title)
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h2))
                            .foregroundColor(Color("Yellow"))
                            .padding(.leading)
                        GroupBox {
                            ForEach(section.rows, id: \.self) { rowInfo in
                                
                                ListInfoRowView(label: rowInfo.title, icon: rowInfo.emojiIcon, value: rowInfo.value, colorText: nil)
                                Divider()
                                
                            }
                        }
                        
                    }
                }
                
                ScrollView(.horizontal) {
                    
                    LazyHStack {
                        ForEach(presenter.characters.data, id: \.id) { presentation in
                            
                            NavigationLink {
                                makeDestination(for: presentation)
                            } label: {
                                GroupBox {
                                    VStack(alignment: .leading) {
                                        URLImage(imageURL: presentation.image)
                                            .scaledToFit()
                                            .cornerRadius(12)
                                        VStack(alignment: .leading) {
                                            Text(presentation.name)
                                                .font(.customFont(font: .montserratFont, style: .bold, size: .h3))
                                                .lineLimit(1)
                                                .foregroundColor(Color("DefaultColor"))
                                            HStack {
                                                Image(systemName: "circle.fill")
                                                    .foregroundColor(Color(presentation.model.status.statusColor))
                                                    .font(.system(size: 8))
                                                Text("\(presentation.model.status.rawValue.capitalizedFirstLetter()) - \(presentation.model.species)")
                                                    .font(.customFont(font: .montserratFont, style: .medium, size: .h12))
                                                    .minimumScaleFactor(0.5)
                                                    .lineLimit(1)
                                                    .foregroundColor(Color("DefaultColor"))
                                            }
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Last Known location:")
                                                    .font(.customFont(font: .montserratFont, style: .medium, size: .h12))
                                                    .foregroundColor(.gray)
                                                Text(presentation.model.location.name)
                                                    .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                                                    .minimumScaleFactor(0.5)
                                                    .lineLimit(1)
                                                    .foregroundColor(Color("DefaultColor"))

                                            }
                                            .padding(.top,5)
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("First seen in:")
                                                    .font(.customFont(font: .montserratFont, style: .medium, size: .h12))
                                                    .foregroundColor(.gray)
                                                Text(presentation.model.origin.name)
                                                    .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                                                    .minimumScaleFactor(0.5)
                                                    .lineLimit(1)
                                                    .foregroundColor(Color("DefaultColor"))

                                            }
                                            .padding(.top,5)

                                        }
                                    }
                                }
                            }
                }
                    }
           
            }
            
            
        }
        .navigationTitle(viewModel.output.state.name)
        .onAppear(perform: viewModel.input.onAppear)

        }
    
    @ViewBuilder
    private func makeDestination(for character: EpisodeDetailPresenter.CharacterPresenterData) -> some View {
        viewModel.input.showCharacter(character.model)
    }
    
}

