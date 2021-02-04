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

struct APIManager {

    private let serverURL: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master"

    func getItems (completion: @escaping (Result<[Item], Error>) -> ()) {
        guard let url = URL(string: serverURL)?.appendingPathComponent("listing.json") else {
            return
        }
        let request = URLRequest(url: url)

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
            guard let categories = try? decoder.decode([Item].self, from: data) else {
                completion(.failure(APIError.parsingError))
                return
            }

            completion(.success(categories))

        }).resume()
    }

    func getCategories(completion: @escaping (Result<[Category], Error>) -> ()) {
        guard let url = URL(string: serverURL)?.appendingPathComponent("categories.json") else {
            return
        }
        let request = URLRequest(url: url)

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
            guard let categories = try? decoder.decode([Category].self, from: data) else {
                completion(.failure(APIError.parsingError))
                return
            }

            completion(.success(categories))

        }).resume()
    }
}
