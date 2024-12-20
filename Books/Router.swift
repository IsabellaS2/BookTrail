//
//  Router.swift
//  Books
//
//  Created by Isabella Sulisufi on 20/09/2024.
//

import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Codable, Hashable {
        case searchedBookPage(Book)
        case searchResultPage([Book], String)
        case libraryPage([Book])
    }

    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
