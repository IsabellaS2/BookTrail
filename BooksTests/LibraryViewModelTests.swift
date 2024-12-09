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
        sut = LibraryViewModel(books: [])
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Sorting Tests

    func test_sortAscending_byBookTitles() throws {
        // GIVEN
        sut = LibraryViewModel(books: [
            .init(id: 1, title: "z", authors: [], bookshelves: [], subjects: [], downloadCount: 1, languages: []),
            .init(id: 2, title: "a", authors: [], bookshelves: [], subjects: [], downloadCount: 2, languages: []),
            .init(id: 3, title: "c", authors: [], bookshelves: [], subjects: [], downloadCount: 3, languages: [])
        ])

        // WHEN
        sut.sortTitlesByAscending()

        // THEN
        XCTAssertEqual(sut.books.first!.title, "a")
    }

    func test_sortDescending_byBookTitles() throws {
        // GIVEN
        sut = LibraryViewModel(books: [
            .init(id: 1, title: "z", authors: [], bookshelves: [], subjects: [], downloadCount: 4, languages: []),
            .init(id: 2, title: "a", authors: [], bookshelves: [], subjects: [], downloadCount: 5, languages: []),
            .init(id: 3, title: "c", authors: [], bookshelves: [], subjects: [], downloadCount: 6, languages: [])
        ])

        // WHEN
        sut.sortTitlesByDescending()

        // THEN
        XCTAssertEqual(sut.books.first!.title, "z")
    }

    func test_sortAscending_byAuthorsName() throws {
        // GIVEN
        sut = LibraryViewModel(books: [
            .init(id: 1, title: "z", authors: [
                .init(name: "Charles Dickens", birthYear: 1812, deathYear: 1870)
            ], bookshelves: [], subjects: [], downloadCount: 7, languages: []),
            .init(id: 2, title: "a", authors: [
                .init(name: "Jane Austen", birthYear: 1775, deathYear: 1817)
            ], bookshelves: [], subjects: [], downloadCount: 8, languages: []),
            .init(id: 3, title: "c", authors: [
                .init(name: "Mark Twain", birthYear: 1835, deathYear: 1910)
            ], bookshelves: [], subjects: [], downloadCount: 9, languages: [])
        ])

        // WHEN
        sut.sortAuthorsNameByAscending()

        // THEN
        XCTAssertEqual(sut.books.first?.authors.first?.name, "Charles Dickens")
        XCTAssertEqual(sut.books.last?.authors.first?.name, "Mark Twain")
    }

    func test_sortDownloads_byMostDownloaded() throws {
        // GIVEN
        sut = LibraryViewModel(books: [
            .init(id: 1, title: "A", authors: [], bookshelves: [], subjects: [], downloadCount: 100, languages: []),
            .init(id: 2, title: "B", authors: [], bookshelves: [], subjects: [], downloadCount: 300, languages: []),
            .init(id: 3, title: "C", authors: [], bookshelves: [], subjects: [], downloadCount: 500, languages: [])
        ])

        // WHEN
        sut.sortByMostDownloaded()

        // THEN
        XCTAssertEqual(sut.books.first!.downloadCount, 500)
        XCTAssertEqual(sut.books.last!.downloadCount, 100)
    }

    /// Filtering Tests

    func test_filterBookTitles_byFictionCategory() throws {
        // GIVEN
        sut = LibraryViewModel(books: [
            .init(id: 1, title: "z", authors: [], bookshelves: [], subjects: ["Fiction", "Horror"],
                  downloadCount: 4, languages: []),
            .init(id: 2, title: "a", authors: [], bookshelves: [], subjects: ["Harvard Classics"],
                  downloadCount: 5, languages: []),
            .init(id: 3, title: "c", authors: [], bookshelves: [], subjects: ["Fiction", "Romance"],
                  downloadCount: 6, languages: [])
        ])

        // WHEN
        sut.getBooksByCategory(category: "Fiction")

        // THEN
        XCTAssertEqual(sut.books.first?.subjects.first, "Fiction")
    }

    func test_filterBookTitles_byAuthorName() throws {
        // GIVEN
        sut = LibraryViewModel(books: [
            .init(id: 1, title: "z", authors: [
                .init(name: "Charles Dickens", birthYear: 1812, deathYear: 1870)
            ], bookshelves: [], subjects: [], downloadCount: 7, languages: []),
            .init(id: 2, title: "a", authors: [
                .init(name: "Jane Austen", birthYear: 1775, deathYear: 1817)
            ], bookshelves: [], subjects: [], downloadCount: 8, languages: []),
            .init(id: 3, title: "c", authors: [
                .init(name: "Mark Twain", birthYear: 1835, deathYear: 1910)
            ], bookshelves: [], subjects: [], downloadCount: 9, languages: [])
        ])

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
