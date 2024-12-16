//
//  LibraryViewModel.swift
//  Books
//
//  Created by Isabella Sulisufi on 13/12/2024.
//

import SwiftUI

class LibraryViewModel: ObservableObject {
    @Published var books: [Book]
    @Published var originalBooks: [Book]

    @Published var libraryBookSearch: String = ""

    init(books: [Book]) {
        self.books = books
        self.originalBooks = books
    }

    // Sorting
    // Titles
    func sortTitlesByAscending() {
        books = books.sorted(by: { bookA, bookB in
            bookA.title < bookB.title
        })
    }

    func sortTitlesByDescending() {
        books = books.sorted(by: { bookA, bookB in
            bookA.title > bookB.title
        })
    }

    // Authors
    func sortAuthorsByAscending() {
        books = books.sorted { ($0.authors.first?.birthYear ?? Int.max) < ($1.authors.first?.birthYear ?? Int.max) }
    }

    func sortAuthorsNameByAscending() {
        books = books.sorted { bookA, bookB in
            bookA.authors.first!.name < bookB.authors.first!.name
        }
    }

    func sortByMostDownloaded() {
        books = books.sorted { $0.downloadCount > $1.downloadCount }
    }

    // Filtering
    func getBooksByCategory(category: String) {
        books = books.filter { book in
            book.subjects.contains(where: { $0.localizedCaseInsensitiveContains(category) }) ||
                book.bookshelves.contains(where: { $0.localizedCaseInsensitiveContains(category) })
        }
    }

    func getBooksByAuthor(authorName: String) {
        books = originalBooks.filter { book in
            book.authors.contains { $0.name.localizedCaseInsensitiveContains(authorName) }
        }
    }

    func clearBooks() {
        books = originalBooks
    }
}
