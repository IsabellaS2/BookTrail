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
        let viewModel = ViewModel(router: router, networkRepository: BookRepository())
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView(viewModel: viewModel)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case let .searchedBookPage(book):
                            SearchedBookView(viewModel: viewModel, clickedBook: book)

                        case let .searchResultPage(books, searchedWord):
                            SearchResultView(viewModel: viewModel, books: books, searchedWord: searchedWord)

                        case let .libraryPage(books):
                            LibraryView(viewModel: LibraryViewModel(books: books))
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
