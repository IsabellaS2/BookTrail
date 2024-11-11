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
                }, label: {
                    Text("Go")
                        .font(Font.custom("Cochin", size: 24))
                        .foregroundColor(Color("darkestBrown"))
                        .padding(.bottom, 20.0)
                })
                .sheet(isPresented: $viewModel.showHomeSheet, content: {
                    VStack(spacing: 8) {
                        Text("The title you have entered is not available, please try again!")
                    }
                    .presentationDetents([.fraction(0.25)])
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
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 50.0)

                // Gothic Fiction
                VStack(alignment: .leading) {
                    Text("Gothic Fiction")
                        .font(Font.custom("Cochin", size: 24))
                        .foregroundColor(Color("darkestBrown"))
                        .multilineTextAlignment(.leading)

                    ScrollView(.horizontal) {
                        HStack {
                            let bookTitles = viewModel.getBooksByCategory(bookTitle: "Gothic Fiction").prefix(5)

                            if bookTitles.isEmpty {
                                Text("No books found")
                                    .font(Font.custom("Cochin", size: 20))
                                    .foregroundColor(Color("darkestBrown"))
                                    .multilineTextAlignment(.center)
                            } else {
                                ForEach(bookTitles, id: \.self) { title in
                                    VStack {
                                        Rectangle()
                                            .frame(width: 96.0, height: 114.0)
                                            .foregroundColor(Color("caramel"))

                                        Text(title)
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
                Spacer()
            }
            .padding()
            .task {
                await viewModel.fetchBookRepo()
            }
        }
        .background(Color("background"))
    }
}
