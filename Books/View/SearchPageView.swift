//
//  SearchPageView.swift
//  Books
//
//  Created by Isabella Sulisufi on 20/09/2024.
//

import SwiftUI

struct SearchPageView: View {
    @ObservedObject var viewModel: ViewModel
    let clickedBook: Book

    private var bookTitles: [String] {
        if let firstSubject = clickedBook.subjects.first {
            return viewModel.getBooksForMatchedGenre(subject: firstSubject)
        }
        return []
    }

    var body: some View {
        ScrollView {
            VStack {

                // Logo Icon Section
                HStack {
                    Image(systemName: "book")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .foregroundColor(Color("brownbrown"))

                    Text("Booktrail")
                        .font(Font.custom("Inknut Antiqua", size: 15))
                        .foregroundColor(Color("darkestBrown"))
                    Spacer()
                }
                .padding(.leading, 18.0)

                Text(viewModel.bookEntered)


                // Book Information
                HStack {
                    Rectangle()
                        .frame(width: 120.0, height: 155.0)
                        .foregroundColor(Color("caramel"))

                    VStack(alignment: .leading) {
                        Text(clickedBook.title)
                            .font(Font.custom("Cochin", size: 25))
                            .foregroundColor(Color("brownbrown"))

                        Text(clickedBook.authors[0].name)
                            .font(Font.custom("Cochin", size: 18))
                            .foregroundColor(Color("brownbrown"))

                        let birthYear = clickedBook.authors.first?.birthYear.map { "\($0)" } ?? "Unknown"
                        let deathYear = clickedBook.authors.first?.deathYear.map { "\($0)" } ?? "Unknown"

                        Text("\(birthYear) - \(deathYear)")
                            .font(Font.custom("Cochin", size: 14))
                            .foregroundColor(Color("brownbrown"))
                            .padding(.bottom, 4.0)
                        Spacer()
                    }
                    .padding(.leading, 5.0)

                    Spacer()
                }
                .padding(25.0)

                // Subjects
                HStack {
                    VStack(alignment: .leading) {

                        Text("Subjects")
                            .font(Font.custom("Cochin", size: 18))
                            .foregroundColor(Color("brownbrown"))

                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(clickedBook.subjects, id: \.self) { subject in
                                Text("\u{2022} \(subject)")
                                    .font(Font.custom("Cochin", size: 16))
                                    .foregroundColor(Color("brownbrown"))
                            }
                        }
                    }
                    .padding([.leading, .bottom], 25.0)
                    Spacer()
               }

                // Book by category
                VStack(alignment: .leading) {
                    if let matchedGenre = viewModel.findMatchedGenre(for: clickedBook.subjects.first ?? "") {
                        Text("Other books in \(matchedGenre)")
                            .font(Font.custom("Cochin", size: 24))
                            .foregroundColor(Color("darkestBrown"))
                            .multilineTextAlignment(.leading)

                        let bookTitles = viewModel.getBooksForMatchedGenre(subject: matchedGenre).prefix(8)

                        ScrollView(.horizontal) {
                            HStack {
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
                }
                .padding(.bottom, 50.0)
                .padding(.leading, 20)
                Spacer()

                // Other books by authors name
                let bookTitlesByAuthor = viewModel.getBooksByAuthor(
                    authorsName: clickedBook.authors[0].name,
                    excluding: clickedBook.title
                )

                if !bookTitlesByAuthor.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Other books by \(clickedBook.authors[0].name)")
                            .font(Font.custom("Cochin", size: 24))
                            .foregroundColor(Color("darkestBrown"))
                            .multilineTextAlignment(.leading)

                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(bookTitlesByAuthor, id: \.self) { title in
                                    VStack {
                                        Rectangle()
                                            .frame(width: 96.0, height: 114.0)
                                            .foregroundColor(Color("caramel"))

                                        Text(title)
                                            .font(Font.custom("Cochin", size: 20))
                                            .foregroundColor(Color("darkestBrown"))
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 96.0, height: 70.0)
                                            .lineLimit(nil)
                                            .padding(.top, 8.0)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .padding(.trailing, 20.0)
                                }
                            }
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 30)
                }

            }
        }
        .background(Color("background"))

    }
}
