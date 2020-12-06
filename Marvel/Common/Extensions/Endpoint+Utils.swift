//
//  Endpoint+Utils.swift
//  Marvel
//
//  Created by Luiz Durães on 31/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

extension AppConfig.Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
