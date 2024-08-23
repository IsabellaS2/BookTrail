//
//  Model.swift
//  Books
//
//  Created by Isabella Sulisufi on 22/08/2024.
//

import Foundation

struct Book {
    var id: Int //accessing each book
    var title: String //book title
    var authors: [Author]
    let bookshelves: [String] //bookshelves the books would be on, would be useful for searching/filtering
    var subjects: [String] //similar to bookshelves but more and for every book
    var downloadCount: Int
    
    //useful for searching e.g. books from certain author/time period
    struct Author {
        let name: String
        let birthYear: Int
        let deathYear: Int
    } 
}
