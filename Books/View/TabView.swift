//
//  TabView.swift
//  Books
//
//  Created by Isabella Sulisufi on 13/12/2024.
//

import SwiftUI

struct TabButton: View {
    let image: String
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)

                Text(text)
            }
        }
        .tint(Color("darkestBrown"))
    }
}

struct TabView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            TabButton(image: "house", text: "Home") {
                print("Go to Home")
            }
            Spacer()
            TabButton(image: "books.vertical", text: "Library") {
                viewModel.navigateToLibrary()
                print("Go to Library")
            }
        }
        .padding(.horizontal, 60.0)
        .frame(height: 82)
    }
}
