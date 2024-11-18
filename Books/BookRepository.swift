//
//  BookRepository.swift
//  Books
//
//  Created by Isabella Sulisufi on 06/09/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class BookRepository {
    func fetchBookRepo() async throws -> [Book] {
        let endpoint = "https://gutendex.com/books/"

        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let booksResponse = try decoder.decode(BooksResponse.self, from: data)
            return booksResponse.results

        } catch {
            throw NetworkError.decodingError
        }
    }
}
