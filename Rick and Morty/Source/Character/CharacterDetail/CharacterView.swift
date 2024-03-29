//
//  CharacterView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

struct CharacterView<ViewModel>: View where ViewModel: CharacterDetailViewModelType {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        let presentation = viewModel.output
          
            List  {
                Section {
                    URLImage(imageURL: presentation.state.image)
                                           .scaledToFit()
                                           .frame(maxWidth: .infinity)
                                           .cornerRadius(6)
                                           .overlay {
                                               RoundedRectangle(cornerRadius: 6)
                                                   .stroke(Color(presentation.state.sections[0].rows[0].statusColor!), lineWidth: 3)
                                           }
                                           
                } header: {
                    Text("Appearance")
                        .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                }

                
                ForEach(presentation.state.sections, id: \.self) { section in
                            Section {
                                ForEach(section.rows, id: \.self) { rowInfo in

                                    ListInfoRowView(label: rowInfo.title, icon: rowInfo.emojiIcon, value: rowInfo.value, colorText: rowInfo.statusColor)
                                }
                            } header: {
                                HStack {
                                    Image(systemName: section.systemImage)
                                        .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                                        .foregroundColor(Color("DefaultColor"))
                                    Text(section.title)
                                        .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                                    
                                    
                                    
                                }
                               
                            }


                        }
                Section {
                    ForEach(presentation.state.episodes.data, id: \.self) { episodePresentation in
                        
                        NavigationLink {
                            viewModel.input.showEpisode(episodePresentation.model)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(episodePresentation.title)
                                    .font(.customFont(font: .montserratFont, style: .bold, size: .h2))
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                                Text(episodePresentation.airDate)
                                    .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                            }
                        }

                        
                    }
                } header: {
                    HStack {
                        Image(systemName: "film.stack")
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                            .foregroundColor(Color("DefaultColor"))
                        
                        Text(presentation.state.episodesSectionTitle)
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                    }
                    

                }

            }
            .navigationBarTitle("\(viewModel.output.state.name)", displayMode: .large)
            .onAppear(perform: viewModel.input.onAppear)
            .scrollIndicators(.hidden)
    }
}

//struct CharacterView_Previews: PreviewProvider {
//   static let dependencies = CharacterDetailModuleFactory()
//    static var previews: some View {
//       CharacterView(viewModel: dependencies.make(character: mockCharacterList[0]))
//            .colorScheme(.dark)
//
//    }
//}
