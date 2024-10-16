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
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(books) { book in
                Button {
                    selectedBook = book
                    showSheet = true
                } label: {
                    Text(book.title)
                }
                
            }
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 8) {
                Text(selectedBook?.title ?? "")
                Text((String(describing: selectedBook?.downloadCount)))
            }
            .presentationDetents([.fraction(0.15)])
                                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    SearchResultView(books:[])
}
