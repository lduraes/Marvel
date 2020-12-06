//
//  CharacterProvider.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import UIKit
import CryptoSwift

protocol CharacterProviderDelegate: AnyObject {
    func fetchCharacterList(offset: Int, itemsPerRequest: Int, completionhandler: @escaping (Result<Marvel, HttpProviderError>) -> Void)
}

final class CharacterProvider: HttpProvider {
    fileprivate let path = "/v1/public/characters"
}

// MARK: - CharacterProviderDelegate methods
extension HttpProvider: CharacterProviderDelegate {
    func fetchCharacterList(offset: Int, itemsPerRequest: Int, completionhandler: @escaping (Result<Marvel, HttpProviderError>) -> Void) {
        let timeStamp = String(Date.currentTimeStamp)
        let hash = (timeStamp + AppConfig.apiPrivateKey + AppConfig.apiPublicKey).md5()
        let queryItems = [URLQueryItem(name: "apikey", value: AppConfig.apiPublicKey),
                          URLQueryItem(name: "ts", value: timeStamp),
                          URLQueryItem(name: "hash", value: hash),
                          URLQueryItem(name: "offset", value: String(offset)),
                          URLQueryItem(name: "limit", value: String(itemsPerRequest))]
        let endpoint = AppConfig.Endpoint(path: CharacterProvider().path, queryItems: queryItems)
        
        fetch(endpoint: endpoint) { result in
           completionhandler(result)
        }
    }
}
