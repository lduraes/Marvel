//
//  MarvelData.swift
//  Marvel
//
//  Created by Luiz Durães on 31/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

struct CharacterData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Marvel: Codable {
    let copyright: String
    let attributionText: String
    let etag: String
    let data: CharacterData
}
