//
//  HttpProvider.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

import UIKit

protocol HttpProviderProtocol {
    func fetch<T>(endpoint: AppConfig.Endpoint, completionHandler: @escaping (Result<T, HttpProviderError>) -> Void) where T: Codable
}

enum HttpProviderError: Error {
    case invalidUrl
    case invalidResponse
    case unavailable
    case decoding
}

// MARK: - HttpProviderProtocol methods
class HttpProvider: HttpProviderProtocol {
    func fetch<T>(endpoint: AppConfig.Endpoint, completionHandler: @escaping (Result<T, HttpProviderError>) -> Void) where T: Codable {
        guard let url = endpoint.url else {
            return completionHandler(.failure(.invalidUrl))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    return completionHandler(.failure(.invalidResponse))
                }
                
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(.success(decoded))
                    } catch {
                        print("[ERR] HttpProvider >> \(error.localizedDescription)")
                        completionHandler(.failure(.decoding))
                    }
                } else {
                    completionHandler(.failure(.unavailable))
                }
            }
        }.resume()
    }
}
