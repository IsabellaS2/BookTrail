//
//  ViewModel.swift
//  Books
//
//  Created by Isabella Sulisufi on 20/08/2024.
//

import Foundation
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
    
    @Published var emptysearch: String = ""
    
    @EnvironmentObject var router: Router

    
    private let networkRepository = BookRepository()
    
    func navigateToSearch() {
        router.navigate(to: .searchedPage(bookEntered))
    }
    
    //What is shown on the view screen
    var mostDownloadedBookText: String {
        viewData?.mostDownloadedBook ?? "No Data"
    }

    var downloadTotalText: String {
        viewData?.downloadTotal ?? "No Data"
    }
    
    //CODE WORKING OUTS
    
    // Fetch books using the repository
    func fetchBookRepo() async {
        do {
            books = try await networkRepository.fetchBookRepo()
            getMostDownloaded()
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
    
    // Handle search button functionality
    func searchButtonFunctionality() {
        let bookTitles = books.map { $0.title }
        
        let searchedBooks = books.filter { $0.title.contains(bookEntered) }
        print(searchedBooks.map{ $0.title })
        
        if bookTitles.contains(bookEntered) {
            message = "We have your book, yay!"
        } else {
            message = "Sorry, we do not have your book!"
        }
    }
    
    // Sort books alphabetically
    func sortBooksAlphabetically() {
        let bookTitles = books.map { $0.title }
        let sortedTitles = bookTitles.sorted { $0.lowercased() < $1.lowercased() }
        
        // Prints all the titles sorted
        sortedTitles.forEach { print($0) }
        
        //Prints just the first item
        print(sortedTitles[0])
    }
    
    // Get the most downloaded book
    func getMostDownloaded() {
        if let book = books.max(by: { $0.downloadCount < $1.downloadCount }) {
            viewData = HomeViewData(mostDownloadedBook: book.title, downloadTotal: "Downloaded: \(book.downloadCount) times")
        }
    }
}
