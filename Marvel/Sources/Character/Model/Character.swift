//
//  Character.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    
    var fullPath: String {
        return path + "." + `extension`
    }
}

struct CharacterSeriesItem: Codable, Equatable {
    let resourceURI: String
    let name: String
    
    // MARK: - Equatable methods
    static func == (lhs: CharacterSeriesItem, rhs: CharacterSeriesItem) -> Bool {
        return lhs.resourceURI == rhs.resourceURI &&
            lhs.name == rhs.name
    }
}

struct CharacterSeries: Codable, Equatable {
    let available: Int
    let collectionURI: String
    let items: [CharacterSeriesItem]

    // MARK: - Equatable methods
    static func == (lhs: CharacterSeries, rhs: CharacterSeries) -> Bool {
        return lhs.available == rhs.available &&
            lhs.collectionURI == rhs.collectionURI &&
            lhs.items == rhs.items
    }
}

enum CharacterUrlType: String, Codable {
    case detail
    case wiki
    case comiclink
}

struct CharacterUrl: Codable, Equatable {
    let type: CharacterUrlType
    let url: String
    
    // MARK: - Equatable methods
    static func == (lhs: CharacterUrl, rhs: CharacterUrl) -> Bool {
        return lhs.type == rhs.type &&
            lhs.url == rhs.url
    }
}

struct Character: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let series: CharacterSeries
    let urls: [CharacterUrl]

    // MARK: - Computed Properties
    var detailUrl: URL? {
        return URL(string: getUrlFromCharacter(type: .detail))
    }

    var wikiUrl: URL? {
        return URL(string: getUrlFromCharacter(type: .wiki))
    }
    
    var movies: String {
        var movies = ""
        
        series.items.customEnumeration.forEach { (index, characterSeriesItem) in
            movies.append("\(index). \(characterSeriesItem.name)\n")
        }
        
        return movies.localizedCapitalized
    }
    
    // MARK: - Private methods
    private func getUrlFromCharacter(type: CharacterUrlType) -> String {
        if let charaterUrl = urls.first(where: { $0.type == type }) {
            return charaterUrl.url
        }
        
        return String()
    }
    
    // MARK: - Equatable methods
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.series == rhs.series &&
            lhs.urls == rhs.urls
    }
}
