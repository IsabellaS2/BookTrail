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
    
    
    func present() {
        books = [
            .init(id: 1, title: "title 1", authors: [], bookshelves: [], subjects: [], downloadCount: 1),
            .init(id: 2, title: "title 2", authors: [], bookshelves: [], subjects: [], downloadCount: 500),
            .init(id: 3, title: "title 3", authors: [], bookshelves: [], subjects: [], downloadCount: 100),
            .init(id: 4, title: "title 4", authors: [], bookshelves: [], subjects: [], downloadCount: 10),
        ]
    }
    
    func searchButtonFunctionality() {
    
    }
    
    func getMostDownloaded() {
        if let book = books.map({ ($0.downloadCount, $0.title) }).sorted(by: { $0.0 > $1.0 }).first {
            self.viewData = HomeViewData(mostDownloadedBook: book.1, downloadTotal: "downloaded: \(book.0) times")
        }
    }
}

