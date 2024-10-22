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
                HomeView(viewModel: ViewModel(router: router))
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        //                        case let .searchedPage(bookId):
                        //                            SearchPageView()
                        case let .searchResultPage(books):
                            SearchResultView(books: books)
                        }
                    }
            }
            .environmentObject(router)

        }
    }
}
