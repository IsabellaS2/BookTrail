//
//  Book.swift
//  Books
//
//  Created by Isabella Sulisufi on 22/08/2024.
//

import Foundation

// The top-level response struct that includes metadata and the list of books
struct BooksResponse: Codable {
    let results: [Book]              // Array of books
}

// Struct representing each book in the results array
struct Book: Codable {
    var id: Int                      // Unique identifier for each book
    var title: String                // Title of the book
    var authors: [Author]            // List of authors associated with the book
    let bookshelves: [String]        // Bookshelves/categories the book belongs to, useful for filtering
    var subjects: [String]           // Subjects or tags associated with the book for detailed search
    var downloadCount: Int           // Number of times the book has been downloaded, useful for popularity sorting
    var languages: [String]          // Languages the book is available in

    // Nested Author struct
    struct Author: Codable {
        let name: String             
        let birthYear: Int?
        let deathYear: Int?
    }
}
