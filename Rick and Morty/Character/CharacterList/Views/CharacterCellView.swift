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
                VStack(alignment: .leading) {
                    Text(presentation.name)
                        .font(.customFont(font: .montserratFont, style: .bold, size: .h0))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(Color("DefaultColor"))
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color(presentation.model.status.statusColor))
                            .font(.system(size: 12))
                        Text("\(presentation.model.status.rawValue.capitalizedFirstLetter()) - \(presentation.model.species)")
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h2))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .foregroundColor(Color("DefaultColor"))
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Last Known location:")
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                            .foregroundColor(.gray)
                        Text(presentation.model.location.name)
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h2))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .foregroundColor(Color("DefaultColor"))

                    }
                    .padding(.top, 20)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("First seen in:")
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
                            .foregroundColor(.gray)
                        Text(presentation.model.origin.name)
                            .font(.customFont(font: .montserratFont, style: .medium, size: .h2))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .foregroundColor(Color("DefaultColor"))

                    }
                    .padding(.top, 20)

                }
            }
        }
     
//        ZStack(alignment: .bottom) {
//            URLImage(imageURL: presentation.image)
//                .scaledToFill()
//            Text(presentation.name)
//                .font(.customFont(font: .montserratFont, style: .medium, size: .h2))
//                .foregroundColor(Color("DefaultColor"))
//                .multilineTextAlignment(.center)
//                .frame(maxWidth: .infinity)
//                .padding([.all], 6)
//                .background(Color.primary.colorInvert().opacity(0.50))
//
//        }
//        .overlay {
//            RoundedRectangle(cornerRadius: 6)
//                .stroke(Color(presentation.model.status.statusColor), lineWidth: 2)
//        }
    }
}

struct CharacterCellView_Previews: PreviewProvider {
    static let presentation: CharacterPresenter = CharacterPresenter(image: mockCharacterList[0].image, name: mockCharacterList[0].name, model: mockCharacterList[0])
    static var previews: some View {
        CharacterCellView(presentation: presentation)
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
