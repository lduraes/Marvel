//
//  AppConfig.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import Keys

struct AppConfig {
    static let apiPublicKey = MarvelKeys().marvelAPIPublicKey
    static let apiPrivateKey = MarvelKeys().marvelAPIPrivateKey
    
    struct Storyboard {
        static let main = "Main"
    }
    
    struct DefaultImage {
        let unavailable: UIImage = #imageLiteral(resourceName: "icon-unavailable")
    }
    
    struct Endpoint {
        let path: String
        let queryItems: [URLQueryItem]
    }
}
