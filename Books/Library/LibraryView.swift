//
//  LibraryView.swift
//  Books
//
//  Created by Isabella Sulisufi on 18/11/2024.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: LibraryViewModel

    var body: some View {
        ScrollView {
            VStack {
                LogoSection()

                // Title Text
                Text("Library of Books")
                    .font(Font.custom("Cochin", size: 30))
                    .foregroundColor(Color("darkestBrown"))
                    .padding(.vertical, 13.0)

                // Search Bar
                TextField("Search...", text: $viewModel.libraryBookSearch)
                    .padding(.leading, 12.0)
                    .font(Font.custom("Cochin", size: 18))
                    .frame(height: 40.0)
                    .background(Color("caramel"))
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)

                // Sort and Filter
                HStack {
                    Menu {
                        Button("Ascending Book Titles", action: viewModel.sortTitlesByAscending)
                        Button("Descending Book Titles", action: viewModel.sortTitlesByDescending)
                        Button("Most Download", action: viewModel.sortByMostDownloaded)
                        Button("Alphabetical Authors Name", action: viewModel.sortAuthorsNameByAscending)

                    } label: {
                        Label("Sorting", systemImage: "arrow.up.arrow.down")
                            .foregroundColor(Color("brownbrown"))
                    }

                    Spacer()

                    Menu {
                        Menu("Authors") {
                            Button("Charles Dickens") { viewModel.getBooksByAuthor(authorName: "Dickens, Charles") }
                            Button("William Shakespeare") {
                                viewModel.getBooksByAuthor(authorName: "Shakespeare, William")
                            }
                            Button("Oscar Wilde") { viewModel.getBooksByAuthor(authorName: "Wilde, Oscar") }
                            Button("Tobias Smollett") {
                                viewModel.getBooksByAuthor(authorName: "Smollett, T. (Tobias)")
                            }

                        }
                        Menu("Subjects") {
                            Button("Harvard Classics") { viewModel.getBooksByCategory(category: "Harvard Classics") }
                            Button("Literature") { viewModel.getBooksByCategory(category: "Literature") }
                            Button("History") { viewModel.getBooksByCategory(category: "History") }
                            Button("Humour") { viewModel.getBooksByCategory(category: "Humour") }
                            Button("Psychology") { viewModel.getBooksByCategory(category: "Psychology") }
                            Button("Drama") { viewModel.getBooksByCategory(category: "Drama") }
                            Button("Movie Books") { viewModel.getBooksByCategory(category: "Movie Books") }
                            Button("Horror") { viewModel.getBooksByCategory(category: "Horror") }
                            Button("Science-Fiction & Fantasy") {
                                viewModel.getBooksByCategory(category: "Science-Fiction & Fantasy")
                            }
                            Button("Children's Literature") {
                                viewModel.getBooksByCategory(category: "Children's Literature")
                            }
                            Button("Culture/Civilization/Society") {
                                viewModel.getBooksByCategory(category: "Culture/Civilization/Society")
                            }

                        }

                    } label: {
                        Label("Filtering", systemImage: "scissors")
                            .foregroundColor(Color("brownbrown"))
                    }
                }
                .padding(.horizontal, 20.0)

                Button {
                    viewModel.clearBooks()
                } label: {
                    Text("Clear Selection")
                        .foregroundColor(Color("darkestBrown"))
                }

                // Book Section
                VStack {
                    ForEach(viewModel.books) { book in
                        Button(action: {
                            // viewModel.navigateToSelectedBook(with: book)
                        }, label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    // Book title
                                    Text("\(book.title) by \(book.authors.map { $0.name }.joined(separator: ", "))")
                                        .foregroundColor(Color("darkestBrown"))
                                        .font(Font.custom("Iowan Old Style", size: 18))
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 30, height: 25)
                                    .foregroundColor(Color("brownbrown"))
                            }
                            .padding()
                            .background(Color("sandBrown"))
                            .cornerRadius(8)
                        })
                    }
                }
            }
            .padding(.leading, 20.0)
            .padding(.trailing, 20.0)
        }
        .background(Color("background"))

    }
}
