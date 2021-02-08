//
//  NetworkManager.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

enum APIError: Error {
    case urlError
    case noDataError
    case parsingError
}

enum APIEndpoint {
    case categories
    case items

    var apiPath: String {
        switch self {
        case .categories: return "categories.json"
        case .items: return "listing.json"
        }
    }

    var httpMethod: String {
        switch self { case .categories, .items: return "GET" }
    }
}

struct APIManager {
    static let shared: APIManager = APIManager()

    private let serverURL: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master"

    private func callAPI<T: Codable>(endPoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: serverURL)?.appendingPathComponent(endPoint.apiPath) else {
            completion(.failure(APIError.urlError))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endPoint.httpMethod

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
           }

            guard let data = data else {
                completion(.failure(APIError.noDataError))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            guard let response = try? decoder.decode(T.self, from: data) else {
                completion(.failure(APIError.parsingError))
                return
            }

            completion(.success(response))

        }).resume()
    }

    func getItems (completion: @escaping (Result<[Item], Error>) -> ()) {
        self.callAPI(endPoint: .items, completion: completion)
    }

    func getCategories(completion: @escaping (Result<[ItemCategory], Error>) -> ()) {
        self.callAPI(endPoint: .categories, completion: completion)
    }
}
