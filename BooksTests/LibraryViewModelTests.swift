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

    func test_sortAscending_byBookTitles() throws {
        //GIVEN
        sut = LibraryViewModel(books:
                                [.init(id: 1, title: "z", authors: [], bookshelves: [], subjects: [], downloadCount: 6, languages: []),
                                .init(id: 2, title: "a", authors: [], bookshelves: [], subjects: [], downloadCount: 6, languages: []),
                                .init(id: 3, title: "c", authors: [], bookshelves: [], subjects: [], downloadCount: 6, languages: []) ])
                            
        //WHEN
        sut.sortTitlesByAscending()
        
        //THEN
        XCTAssertEqual(sut.books.first!.title, "a")
    }
    
    func test_sortDescending_byBookTitles() throws {
        //GIVEN
        sut = LibraryViewModel(books:
                                [.init(id: 1, title: "z", authors: [], bookshelves: [], subjects: [], downloadCount: 6, languages: []),
                                 .init(id: 2, title: "a", authors: [], bookshelves: [], subjects: [], downloadCount: 6, languages: []),
                                 .init(id: 3, title: "c", authors: [], bookshelves: [], subjects: [], downloadCount: 6, languages: []) ])
        
        //WHEN
        sut.sortTitlesByDescending()
        
        //THEN
        XCTAssertEqual(sut.books.first!.title, "z")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
