//
//  CustomSearchBar.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 13.02.24.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool
    var body: some View {
            HStack {

                TextField("", text: $searchText, onEditingChanged: { isEditing in
                    self.isEditing = isEditing
                })
                .textFieldStyle(IconTextFieldStyle(icon: "search"))
                .placeholder(when: searchText.isEmpty, placeholder: {
                    Text("Search")
                        .foregroundColor(.black.opacity(0.3))
                })
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(Color("ColorSearch"))
                .cornerRadius(10)
                if isEditing {
                    Button("Cancel") {
                        searchText = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        isEditing = false
                    }
                }
            }
            .animation(.easeInOut)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                isEditing = false
            }
        }
}

struct SearchTextField_Previews: PreviewProvider {
    struct Preview: View {
            @State private var searchText = ""
            @State private var isEditing = false

            var body: some View {
                CustomSearchBar(searchText: $searchText, isEditing: $isEditing)
            }
        }

        static var previews: some View {
            Preview()
        }
}
struct IconTextFieldStyle: TextFieldStyle {
    var icon: String
    
    func _body(configuration: TextField<_Label>) -> some View {
        HStack {
            configuration

            Image(icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(width: 20, height: 20)
                .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}
