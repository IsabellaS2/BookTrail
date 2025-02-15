//
//  SearchResultView.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/10/2024.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: ViewModel

    let books: [Book]
    let searchedWord: String

    @State private var showSheet = false
    @State private var selectedBook: Book?

    var body: some View {
        ScrollView {

            VStack(spacing: 8) {

                LogoSection()

                // Title Result Section
                VStack(alignment: .leading) {
                    Text("Results for \"\(self.searchedWord)\"")
                        .font(Font.custom("Iowan Old Style", size: 25))
                        .foregroundColor(Color("darkestBrown"))
                        .padding(.bottom, 4.0)

                    Text("We found \(books.count) books that match your search")
                        .foregroundColor(Color("darkestBrown"))
                        .font(Font.custom("Iowan Old Style", size: 20).italic())
                }
                .padding(.bottom, 30.0)
                .padding(.leading, 0)

                ForEach(books) { book in
                    Button(action: {
                        viewModel.navigateToSelectedBook(with: book)
                    }, label: {
                        HStack {
                            VStack(alignment: .leading) {
                                // Book title
                                Text("\(book.title) by \(book.authors.map { $0.name }.joined(separator: ", "))")
                                    .foregroundColor(Color("darkestBrown"))
                                    .font(Font.custom("Iowan Old Style", size: 18))
                                    .multilineTextAlignment(.leading)

                                // Tag Container
                                HStack {
                                    let uniqueSubjects = Array(Set(book.subjects.map { subject in
                                        subject.components(separatedBy: " -- ").first ?? subject
                                    })).prefix(1)

                                    ForEach(uniqueSubjects, id: \.self) { subject in
                                        HStack(alignment: .center, spacing: 0) {
                                            Text(subject)
                                                .font(Font.custom("Iowan Old Style", size: 14))
                                                .foregroundColor(Color("background"))
                                        }
                                        .padding(.vertical, 4.0)
                                        .padding(.horizontal, 6.0)
                                        .background(Color("caramel"))
                                        .cornerRadius(9)
                                    }

                                    Spacer()
                                }
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
                .background(Color("background"))

            }
            .padding(.horizontal, 18.0)
        }
        .background(Color("background"))
    }
}

// #Preview {
//    SearchResultView(books: [])
// }
