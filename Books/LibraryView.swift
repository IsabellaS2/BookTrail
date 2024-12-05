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
                // Top Logo
                HStack {
                    Image(systemName: "book")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .foregroundColor(Color("brownbrown"))

                    Text("Booktrail")
                        .font(Font.custom("Cochin", size: 25))
                        .foregroundColor(Color("darkestBrown"))
                    Spacer()
                }
                .padding(.leading, 12.0)

                // Title Text
                Text("Library of Books")
                    .font(Font.custom("Cochin", size: 30))
                    .foregroundColor(Color("darkestBrown"))
                    .padding(.vertical, 13.0)

//                // Search Bar
//                TextField("Search...", text: $viewModel.libraryBookSearch)
//                    .padding(.leading, 12.0)
//                    .font(Font.custom("Cochin", size: 18))
//                    .frame(height: 40.0)
//                    .background(Color("caramel"))
//                    .padding(.horizontal)
//                    .textInputAutocapitalization(.never)

                // Sort and Filter
                HStack {
                    Button {
                        viewModel.sortTitlesByAscending()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .frame(width: 23, height: 20)
                            .foregroundColor(Color("brownbrown"))
                        Text("Sort")
                            .font(Font.custom("Cochin", size: 20))
                            .foregroundColor(Color("darkestBrown"))
                    }

                    Spacer()
                    
                    Button {
                        viewModel.sortTitlesByDescending()
                    } label: {
                        HStack {
                            Image(systemName: "scissors")
                                .frame(width: 23, height: 20)
                                .foregroundColor(Color("brownbrown"))
                            Text("Filter")
                                .font(Font.custom("Cochin", size: 20))
                                .foregroundColor(Color("darkestBrown"))
                        }
                    }
                    

                }
                .padding(.horizontal, 20.0)

                // Book Section
                VStack {
                    ForEach(viewModel.books) { book in
                        Button(action: {
//                            viewModel.navigateToSelectedBook(with: book)
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
