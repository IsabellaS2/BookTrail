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
    @Published var showHomeSheet = false
    @Published var selectedBook: Book?

    @Published var genres = ["Fiction", "Literature", "Science-Fiction & Fantasy",
                             "Horror Tales", "Drama", "Poetry", "Best Books Ever Listings",
                             "History", "Society", "Travel & Geography", "Harvard Classics", "Humour"]

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
            books = try await networkRepository.fetchBookRepo()
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
        let searchedBooks = books.filter {
            $0.title.localizedCaseInsensitiveContains(bookEntered)
        }

        if searchedBooks.isEmpty {
            showHomeSheet = true
            bookEntered = ""
        } else {
            showHomeSheet = false
            router.navigate(to: .searchResultPage(searchedBooks, bookEntered))
        }
    }

    func navigateToSelectedBook(with book: Book) {
        selectedBook = book
        router.navigate(to: .searchedPage(book))
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
        return sortedBooks
        // Debugging: Print each book's title and download count
        //        for book in sortedBooks {
        //            print("Title: \(book.title), Downloads: \(book.downloadCount)")
        //        }
    }

    /// Returns a list of book titles ordered by category
    func getBooksByCategory(bookTitle: String) -> [String] {
        var litBookTitles: [String] = []

        for book in books {
            if book.subjects.contains(where: { $0.localizedCaseInsensitiveContains(bookTitle) }) ||
                book.bookshelves.contains(where: { $0.localizedCaseInsensitiveContains(bookTitle) }) {
                litBookTitles.append(book.title)
            }
        }
        return litBookTitles
    }

    /// Returns a list of book titles ordered by author
    func getBooksByAuthor(authorsName: String, excluding title: String) -> [String] {
        var booksByAuthor: [String] = []

        for book in books {
            if book.authors.contains(where: {
                $0.name.localizedCaseInsensitiveCompare(authorsName) == .orderedSame
            }) && book.title != title {
                booksByAuthor.append(book.title)
            }
        }
        return booksByAuthor
    }
    
    func getBooksInTimePeriod(birthYear: Int?, deathYear: Int?) -> [String] {
        var emptyArray: [String] = []

        // Ensure both birthYear and deathYear are non-nil
        guard let birthYear = birthYear, let deathYear = deathYear else {
            return emptyArray
        }
        let modifiedBY = birthYear - 10
        let modifiedDY = deathYear + 10

        for book in books {
            if let author = book.authors.first {
                if let authorBirthYear = author.birthYear, let authorDeathYear = author.deathYear {
                    // Check if author's birth and death year fall within the modified ranges
                    if (authorBirthYear >= modifiedBY && authorBirthYear <= modifiedDY) &&
                       (authorDeathYear >= modifiedBY && authorDeathYear <= modifiedDY) {
                        emptyArray.append(book.title)
                    }
                }
            }
        }

        return emptyArray
    }


    
    
    
//    func getbooboos() -> [String] {
//        var emptyarray: [String] = []
//
//        for book in books {
//            if book.authors.contains(where: {
//                 if let birthYear = $0.birthYear {
//                     return birthYear
//                 }
//                if let deathYear = $0.deathYear {
//                    return deathYear
//                }
//                return false
//             }) {
//                emptyarray.append(book.title)
//                 print("Result array: \(emptyarray)")
//             }
//        }
//        return emptyarray
//    }
    
//    func getBooksInThatTimePeriod(bookTitle: String) {
//        var booksInTimePeriod: [String] = []
//        for book in books {
//            if books.authors.birthYear
//        }
//        
//    }

    // MARK: - Most Downloaded Book

    /// Updates the view data with the most downloaded book and its download count (Not currently used in the UI)
    func getMostDownloaded() {
        if let book = books.max(by: { $0.downloadCount < $1.downloadCount }) {
            viewData = HomeViewData(
                mostDownloadedBook: book.title,
                downloadTotal: "Downloaded: \(book.downloadCount) times")
        }
    }

    /// Find the matched genre for the subject
    func findMatchedGenre(for subject: String) -> String? {
        let matched = genres.first { genre in
            subject.localizedCaseInsensitiveContains(genre)
        }
//        print("Matched genre for subject '\(subject)': \(matched ?? "None")")
        return matched
    }

    /// Fetch books for the matched genre
    func getBooksForMatchedGenre(subject: String) -> [String] {
        guard let matchedGenre = findMatchedGenre(for: subject) else {
            return []
        }

        let books = getBooksByCategory(bookTitle: matchedGenre).prefix(8).map { $0 }

//        print("Books found for genre '\(matchedGenre)':")
//        books.forEach { print($0) }

        return books
    }
    

}
