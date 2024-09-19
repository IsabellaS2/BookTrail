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

//struct NetworkService {
//    
//    func fetchRepo(userName: String) async throws -> [Repository] {
//        
//        guard let url = URL(string: "https://api.github.com/users/\(userName)/repos") else {
//            throw NetworkError.invalidURL
//        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let repositories = try JSONDecoder().decode([Repository].self, from: data)
//            return repositories
//        } catch {
//            throw NetworkError.decodingError
//        }
//    }
//}
//
//class GitHubViewModel {
//        
//    let networkService: NetworkService
//    
//    init(networkService: NetworkService) {
//        self.networkService = networkService
//    }
//    
//    func presentRepositories() async {
//        do {
//            let repositories = try await self.networkService.fetchRepo(userName: "pointfreeco")
//            print(repositories.map { $0.name })
//        } catch {
//            print("Error: \(error)")
//        }
//    }
//}
