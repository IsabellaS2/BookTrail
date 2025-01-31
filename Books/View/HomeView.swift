//
//  ContentView.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/08/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 0) {
                    Image(systemName: "book")
                        .resizable()
                        .frame(width: 67, height: 50)
                        .foregroundColor(Color("brownbrown"))

                    Text("Booktrail")
                        .font(Font.custom("Inknut Antiqua", size: 32))
                        .foregroundColor(Color("darkestBrown"))
                        .onAppear {
                            Task {
                                await viewModel.fetchBookRepo()
                            }
                        }
                }

                Spacer()

                // Search Section
                Text("Find your favourite books here")
                    .font(Font.custom("Cochin", size: 40))
                    .foregroundColor(Color("darkestBrown"))
                    .multilineTextAlignment(.center)

                TextField("Search...", text: $viewModel.bookEntered)
                    .padding(10.0)
                    .frame(height: 40.0)
                    .textInputAutocapitalization(.never)
                    .background(Color("caramel"))

                Button(action: {
                    viewModel.searchButtonFunctionality()
                }, label: {
                    Text("Go")
                        .font(Font.custom("Cochin", size: 24))
                        .foregroundColor(Color("darkestBrown"))
                        .padding(.bottom, 30.0)
                })
                .sheet(isPresented: $viewModel.showHomeSheet, content: {
                    VStack(spacing: 10) {
                        Text("The title you have entered is not available, please try again!")
                        Text("Why not check out the \(viewModel.books.count) library books we have available?")

                        LibraryButton(
                            action: { viewModel.navigateToLibrary() },
                            title: "Go to Library"
                        )

                    }
                    .presentationDetents([.fraction(0.30)])
                    .presentationDragIndicator(.visible)
                })

                // Most downloaded
                VStack(alignment: .leading) {
                    Text("Most Downloaded")
                        .font(Font.custom("Cochin", size: 24))
                        .foregroundColor(Color("darkestBrown"))
                        .multilineTextAlignment(.leading)

                    ScrollView(.horizontal) {
                        HStack {
                            if viewModel.getBooksOrderedByDownloads().prefix(5).isEmpty {
                                Text("Loading...")
                                    .font(Font.custom("Cochin", size: 20))
                                    .foregroundColor(Color("darkestBrown"))
                                    .multilineTextAlignment(.center)
                            } else {
                                ForEach(viewModel.getBooksOrderedByDownloads().prefix(5)) { book in
                                    VStack {
                                        Rectangle()
                                            .frame(width: 96.0, height: 114.0)
                                            .foregroundColor(Color("caramel"))

                                        Text(book.title)
                                            .font(Font.custom("Cochin", size: 20))
                                            .foregroundColor(Color("darkestBrown"))
                                            .multilineTextAlignment(.center)
                                            .frame(width: 96.0, height: 70.0)
                                            .lineLimit(nil)
                                            .padding(.top, 8.0)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .padding(.trailing, 10.0)
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 50.0)

                BookCategoryView(categoryTitle: "Gothic Fiction", books: viewModel.getBooksByCategory(bookTitle: "Gothic Fiction"))

                BookCategoryView(categoryTitle: "Harvard Classics", books: viewModel.getBooksByCategory(bookTitle: "Harvard Classics"))

                Spacer()

                LibraryButton(
                    action: { viewModel.navigateToLibrary() },
                    title: "Library View"
                )

                Spacer()

            }
            .padding()
        }
        .background(Color("background"))
    }
}
