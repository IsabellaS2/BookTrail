//
//  ContentView.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/08/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 67, height: 50)
                    .foregroundColor(Color("brownbrown"))

                Text("Booktrail")
                    .font(Font.custom("Inknut Antiqua", size: 32))
                    .foregroundColor(Color("darkestBrown"))
            }

            Spacer()

            // Search Section
            Text("Find your favourite books here")
                .font(Font.custom("Cochin", size: 40))
                .foregroundColor(Color("darkestBrown"))

            TextField("Search...", text: $viewModel.bookEntered)
                .padding(10.0)
                .frame(height: 40.0)
                .textInputAutocapitalization(.never)
                .background(Color("caramel"))

            Button(action: {
                viewModel.searchButtonFunctionality()
            }) {
                Text("Go")
                    .font(Font.custom("Cochin", size: 24))
                    .foregroundColor(Color("darkestBrown"))
            }
            .sheet(isPresented: $viewModel.showSheet) {
                VStack(spacing: 8) {
                    Text("The title you have entered is not available, please try again!")
                }
                .presentationDetents([.fraction(0.25)])
                .presentationDragIndicator(.visible)
            }

            Spacer()

            // Most downloaded
            VStack(alignment: .leading) {
                Text("Most Downloaded")
                    .font(Font.custom("Cochin", size: 24))
                    .foregroundColor(Color("darkestBrown"))
                    .multilineTextAlignment(.leading)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.getBooksOrderedByDownloads().prefix(5)) { book in
                            VStack {
                                Rectangle()
                                    .frame(width: 96.0, height: 114.0)
                                    .foregroundColor(Color("caramel"))

                                Text(book.title)
                                    .font(Font.custom("Cochin", size: 20))
                                    .foregroundColor(Color("darkestBrown"))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 96.0)
                                    .lineLimit(nil)
                                    .padding(.top, 8)
                            }
                            .padding(.trailing, 10.0)
                        }
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color("background"))
        .task {
            await viewModel.fetchBookRepo()
        }
    }
}

// #Preview {
//    HomeView(viewModel: ViewModel(router: Router))
//        .environmentObject(Router())
// }
