//
//  BooksApp.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/08/2024.
//

import SwiftUI

@main
struct BooksApp: App {
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                let viewModel = ViewModel(router: router, networkRepository: BookRepository())
                HomeView(viewModel: viewModel)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case let .searchedBookPage(book):
                            SearchedBookView(viewModel: viewModel, clickedBook: book)
                            
                        case let .searchResultPage(books, searchedWord):
                            SearchResultView(viewModel: viewModel, books: books, searchedWord: searchedWord)
                            
                        case .libraryPage:
                            LibraryView(viewModel: viewModel)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
