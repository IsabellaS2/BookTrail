//
//  LibraryViewModelTests.swift
//  BooksTests
//
//  Created by Isabella Sulisufi on 05/12/2024.
//

import XCTest
@testable import Books

final class LibraryViewModelTests: XCTestCase {

    var sut: LibraryViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LibraryViewModel(books: [
            .init(id: 1, title: "z", authors: [
                .init(name: "Charles Dickens", birthYear: 1812, deathYear: 1870)
            ], bookshelves: [], subjects: ["Fiction", "Horror"], downloadCount: 500, languages: []),
            .init(id: 2, title: "a", authors: [
                .init(name: "Jane Austen", birthYear: 1775, deathYear: 1817)
            ], bookshelves: [], subjects: ["Harvard Classics"], downloadCount: 300, languages: []),
            .init(id: 3, title: "c", authors: [
                .init(name: "Mark Twain", birthYear: 1835, deathYear: 1910)
            ], bookshelves: [], subjects: ["Fiction", "Romance"], downloadCount: 100, languages: [])
        ])
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Sorting Tests

    func test_sortAscending_byBookTitles() throws {
        // WHEN
        sut.sortTitlesByAscending()

        // THEN
        XCTAssertEqual(sut.books.first!.title, "a")
    }

    func test_sortDescending_byBookTitles() throws {
        // WHEN
        sut.sortTitlesByDescending()

        // THEN
        XCTAssertEqual(sut.books.first!.title, "z")
    }

    func test_sortAscending_byAuthorsName() throws {
        // WHEN
        sut.sortAuthorsNameByAscending()
        let result = sut.books.map {
            $0.authors.first?.name
        }
        XCTAssertEqual(result, ["Charles Dickens","Jane Austen", "Mark Twain"])

        // THEN
//        XCTAssertEqual(sut.books.first?.authors.first?.name, "Charles Dickens")
//        XCTAssertEqual(sut.books.last?.authors.first?.name, "Mark Twain")
    }

    func test_sortDownloads_byMostDownloaded() throws {
        // WHEN
        sut.sortByMostDownloaded()
        let result = sut.books.map {
            $0.downloadCount
        }
        
        // THEN
        XCTAssertEqual(result, [500,300,100])
        
//        XCTAssertEqual(sut.books.first!.downloadCount, 500)
//        XCTAssertEqual(sut.books.last!.downloadCount, 100)
    }

    /// Filtering Tests

    func test_filterBookTitles_byFictionCategory() throws {
        let category = "Fiction"
        // WHEN
        sut.getBooksByCategory(category: category)

        // THEN
//        for book in sut.books {
//            if !book.subjects.contains(category) {
//                XCTFail("There are books which contain other subjects")
//            }
//        }
        let result = sut.books.allSatisfy{ book in
            book.subjects.contains(category)
        }
        XCTAssertEqual(sut.books.count, 2)
        XCTAssertTrue(result)
        
    }

    func test_filterBookTitles_byAuthorName() throws {
        // WHEN
        sut.getBooksByAuthor(authorName: "Charles Dickens")

        // THEN
        XCTAssertEqual(sut.books.count, 1)
        XCTAssertEqual(sut.books.first?.authors.first?.name, "Charles Dickens")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
