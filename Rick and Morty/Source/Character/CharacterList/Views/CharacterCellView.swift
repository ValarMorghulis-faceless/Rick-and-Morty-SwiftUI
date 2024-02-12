//
//  CharacterCellView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import SwiftUI

struct CharacterCellView: View {
    let presentation: CharacterPresenter

    var body: some View {
        
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
                            .lineLimit(1)
                            .foregroundColor(Color("DefaultColor"))
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Last Known location:")
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h12))
                            .foregroundColor(.gray)
                        Text(presentation.model.location.name)
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
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
                            .lineLimit(1)
                            .foregroundColor(Color("DefaultColor"))

                    }
                    .padding(.top,5)

                }
            }
        }

    }
}


struct CharacterCellView_Previews: PreviewProvider {
    static let presentation: CharacterPresenter = CharacterPresenter(image: mockCharacterList[0].image, name: mockCharacterList[0].name, model: mockCharacterList[0])
    static var previews: some View {
        CharacterCellView(presentation: presentation)
    }
}
