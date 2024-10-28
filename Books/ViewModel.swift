//
//  ViewModel.swift
//  Books
//
//  Created by Isabella Sulisufi on 20/08/2024.
//

import SwiftUI

struct HomeViewData {
    let mostDownloadedBook: String
    let downloadTotal: String
}

class ViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var viewData: HomeViewData?
    @Published var bookEntered: String = ""
    @Published var message: String = ""
    @Published var emptySearch: String = ""
    @Published var showSheet = false

    var router: Router

    private let networkRepository: BookRepository

    init(router: Router, networkRepository: BookRepository) {
        self.router = router
        self.networkRepository = networkRepository
    }

    /// Fetches books from the repository asynchronously
    @MainActor
    func fetchBookRepo() async {
        do {
            // Fetch books from the repository
            books = try await networkRepository.fetchBookRepo()
            print(books.count)
        } catch NetworkError.invalidURL {
            message = "Invalid URL"
        } catch NetworkError.invalidResponse {
            message = "Invalid response"
        } catch NetworkError.decodingError {
            message = "Decoding Error"
        } catch {
            message = "Unexpected error: \(error)"
        }
    }
    
    
    
    /// Handles search functionality when user enters a book title
    func searchButtonFunctionality() {
        let searchedBooks = books.filter { $0.title.localizedCaseInsensitiveContains(bookEntered) }

        if searchedBooks.isEmpty {
            showSheet = true
            bookEntered = ""
        } else {
            showSheet = false
            router.navigate(to: .searchResultPage(searchedBooks, bookEntered))
        }
    }
    
    

    // MARK: - Sorting Functions

    /// Sorts books alphabetically (optional, not currently used in the UI)
    func sortBooksAlphabetically() {
        let sortedTitles = books.map { $0.title }.sorted { $0.lowercased() < $1.lowercased() }

        // Debugging: Print sorted titles
        sortedTitles.forEach { print($0) }
    }

    /// Returns a list of books ordered by download count (descending)
    func getBooksOrderedByDownloads() -> [Book] {
        let sortedBooks = books.sorted(by: { $0.downloadCount > $1.downloadCount })

        // Debugging: Print each book's title and download count
        //        for book in sortedBooks {
        //            print("Title: \(book.title), Downloads: \(book.downloadCount)")
        //        }
        return sortedBooks
    }

    // MARK: - Most Downloaded Book

    /// Updates the view data with the most downloaded book and its download count (Not currently used in the UI)
    func getMostDownloaded() {
        if let book = books.max(by: { $0.downloadCount < $1.downloadCount }) {
            viewData = HomeViewData(mostDownloadedBook: book.title, downloadTotal: "Downloaded: \(book.downloadCount) times")
        }
    }
}
