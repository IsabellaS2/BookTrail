//
//  SearchResultView.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/10/2024.
//

import SwiftUI

struct SearchResultView: View {

    let books: [Book]
    @State private var showSheet = false
    @State private var selectedBook: Book?
    
    @State private var numOfBooksFound = 8
    @State private var searchedBooks = "Romeo and Juliet"
    @State private var bookTitle = "Romeo and Juliet"
    @State private var bookAuthor = "Shakespeare"
    @State private var bookCategory1 = "Humour"
    @State private var bookCategory2 = "Romance"

    var body: some View {
        VStack(spacing: 8) {
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
            
            // Title Section
            VStack(alignment: .leading) {
                Text("Results for \"\(searchedBooks)\" ")
                    .font(Font.custom("Iowan Old Style", size: 25))
                    .foregroundColor(Color("darkestBrown"))
                    .padding(.bottom, 4.0)

                Text("We found \(numOfBooksFound) books that match your search")
                    .foregroundColor(Color("darkestBrown"))
                    .font(
                        Font.custom("Iowan Old Style", size: 20)
                            .italic()
                    )
            }
            .padding(.bottom, 50.0)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(bookTitle) by \(bookAuthor)")
                        .foregroundColor(Color("darkestBrown"))
                        .font(Font.custom("Iowan Old Style", size: 20))

                    // Tag Container
                    HStack {
                        HStack(alignment: .center, spacing: 0) { Text("\(bookCategory1)")
                            .font(Font.custom("Iowan Old Style", size: 14))
                            .foregroundColor(Color("background"))
                        }
                        .padding(.vertical, 4.0)
                        .padding(.horizontal, 6.0)
                        .background(Color("caramel"))
                        .cornerRadius(9)

                        HStack(alignment: .center, spacing: 0) { Text("\(bookCategory2)")
                            .font(Font.custom("Iowan Old Style", size: 14))
                            .foregroundColor(Color("background"))
                        }
                        .padding(.vertical, 4.0)
                        .padding(.horizontal, 6.0)
                        .background(Color("caramel"))
                        .cornerRadius(9)
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
            
            ForEach(books) { book in
                Button {
                    selectedBook = book
                    showSheet = true
                } label: {
                    Text(book.title)
                }
            }
            // i wanna map these titles to the cards
            

            
        }
        .background(Color("background"))

    }
}


#Preview {
    SearchResultView(books: [])
}
