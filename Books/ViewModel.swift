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
    
    @Published var status: Bool = false

    @Published var successMessage: String = "We have your book, yay!"
    @Published var failMessage: String = "Sorry, we do not have your book :("

    
    func present() {
        books = [
            .init(id: 1, title: "Title 1", authors: [], bookshelves: [], subjects: [], downloadCount: 1),
            .init(id: 2, title: "apples title 2", authors: [], bookshelves: [], subjects: [], downloadCount: 500),
            .init(id: 3, title: "xcode title 3", authors: [], bookshelves: [], subjects: [], downloadCount: 100),
            .init(id: 4, title: "title 4", authors: [], bookshelves: [], subjects: [], downloadCount: 10),
        ]
    }
    
    
    

    
    func searchButtonFunctionality() {
        let bookTitles = books.map({ ($0.title) })
        
        if bookTitles.contains(bookEntered) {
            status = true
            print("We have your book, yay!")
        } else {
            status = false
            print("Sorry, we do not have your book!")
        }
    }
    
    func sortBooksAlphabetically() {
        let bookTitles = books.map({ $0.title })
        let sortedTitles = bookTitles.sorted(by: { $0.lowercased() < $1.lowercased() })
        
        //Prints all the titles sorted
        for title in sortedTitles {
            print(title)
        }
        
        //Prints just the first item
        print(sortedTitles[0])

    }

    
    func getMostDownloaded() {
        if let book = books.map({ ($0.downloadCount, $0.title) }).sorted(by: { $0.0 > $1.0 }).first {
            self.viewData = HomeViewData(mostDownloadedBook: book.1, downloadTotal: "downloaded: \(book.0) times")
        }
    }
}
