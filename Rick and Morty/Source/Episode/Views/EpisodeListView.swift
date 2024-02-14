//
//  EpisodeListView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

struct EpisodeListView<ViewModel>: View where ViewModel: EpisodeListViewModelType {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationStack {
            stateMainView
                .navigationTitle("Episodes")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: viewModel.input.onAppear)
    }
}

private extension EpisodeListView {
    @ViewBuilder
    var stateMainView: some View {
        switch viewModel.output.state {
        case .display:
            episodesListView
        case .showError(let error):
            VStack(spacing: 6) {
                Text(error.title)
                    .font(.customFont(font: .montserratFont, style: .bold, size: .h0))
                Text(error.description)
            }
        }
    }
    var episodesListView: some View {
        List {
            let episodeList = viewModel.output.state.episodeList
            ForEach(episodeList.data, id: \.self) { episode in
                NavigationLink {
                    viewModel.input.showEpisode(episode.model)
                } label: {
                    VStack(alignment: .leading) {
                        Text(episode.title)
                            .font(.customFont(font: .montserratFont, style: .bold, size: .h2))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text(episode.airDate)
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }

            }
            if episodeList.hasMore {
                HStack(alignment: .center, spacing: 6) {
                                    Spacer()
                                    ProgressView()
                                    Text("Fetching more")
                                        .font(.footnote)
                                        .padding([.top, .bottom])
                                    Spacer()
                                }
                                .onAppear(perform: viewModel.input.scrollViewIsNearBottom)
            }
        }
        
    }
}

//struct EpisodeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodeListView()
//    }
//}
