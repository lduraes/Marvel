//
//  MockCharacter.swift
//  MarvelTests
//
//  Created by Luiz Durães on 02/09/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
@testable import Marvel

class MockCharacter: Decodable {
    // MARK: - Public methods
    func getMarvelMock() throws -> Marvel {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "marvel-partial", ofType: "json") else { fatalError("marvel-partial.json not found") }
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .alwaysMapped)
        let marvel = try JSONDecoder().decode(Marvel.self, from: data)
        
        return marvel
    }
    
    func getFirstCharacter() -> Character {
        return Character(id: 1011334,
                         name: "3-D Man",
                         description: "",
                         modified: "2014-04-29T14:18:17-0400",
                         thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                              extension: "jpg"),
                         series: CharacterSeries(available: 3,
                                                 collectionURI: "http://gateway.marvel.com/v1/public/characters/1011334/series",
                                                 items: [CharacterSeriesItem(resourceURI: "http://gateway.marvel.com/v1/public/series/1945",
                                                                             name: "Avengers: The Initiative (2007 - 2010)"),
                                                         CharacterSeriesItem(resourceURI: "http://gateway.marvel.com/v1/public/series/2005",
                                                                             name: "Deadpool (1997 - 2002)"),
                                                         CharacterSeriesItem(resourceURI: "http://gateway.marvel.com/v1/public/series/2045",
                                                                             name: "Marvel Premiere (1972 - 1981)")]),
                         urls: [CharacterUrl(type: .detail,
                                             url: "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=9eda64e9805ccecae0c6ea2cf9014825"),
                                CharacterUrl(type: .wiki,
                                             url: "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=9eda64e9805ccecae0c6ea2cf9014825"),
                                CharacterUrl(type: .comiclink,
                                             url: "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=9eda64e9805ccecae0c6ea2cf9014825")])
    }
}
