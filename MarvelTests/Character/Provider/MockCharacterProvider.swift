//
//  MockCharacterProvider.swift
//  MarvelTests
//
//  Created by Luiz Durães on 02/09/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

@testable import Marvel

final class MockCharacterProvider: CharacterProviderDelegate {
    // MARK: - Properties
    private let mockCharacter = MockCharacter()
    var simulateError = false
    
    // MARK: - Public methods
    func fetchCharacterList(offset: Int, itemsPerRequest: Int, completionhandler: @escaping (Result<Marvel, HttpProviderError>) -> Void) {
        if simulateError {
            completionhandler(.failure(.unavailable))
        } else {
            do {
                completionhandler(.success(try mockCharacter.getMarvelMock()))
            } catch {
                completionhandler(.failure(.decoding))
            }
        }
    }
}
