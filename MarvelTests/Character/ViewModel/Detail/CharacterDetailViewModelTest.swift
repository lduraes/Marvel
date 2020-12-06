//
//  CharacterDetailViewModelTest.swift
//  MarvelTests
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import XCTest
@testable import Marvel

class CharacterDetailViewModelTest: XCTestCase {
    // MARK: - Properties
    private weak var delegate: MockCharacterDetailViewModel?
    private var provider: MockCharacterProvider!
    fileprivate var viewModel: CharacterDetailViewModel!
    
    override func setUp() {
        super.setUp()
        delegate = MockCharacterDetailViewModel()
        provider = MockCharacterProvider()
        viewModel = CharacterDetailViewModel(delegate: delegate, model: MockCharacter().getFirstCharacter())
    }
    
    override func tearDown() {
        super.tearDown()
        delegate = nil
        provider = nil
        viewModel = nil
    }
    
    func testShouldFetchCharacterDetailSuccessfully() {
        // given
        let successExpectation = XCTestExpectation()
        
        // when
        viewModel.fetchCharacterDetail()
        
        // then
        delegate?.validateShouldFetchCharacterDetailSuccessfully(expectation: successExpectation)
    }
}

private class MockCharacterDetailViewModel {
    // MARK: - Properties
    private var characterDetailWillLoadCalled = false
    private var characterDetailDidLoadCalled = false
    private var characterDetailDidFailLoadCallled = false
    private var character: Character?
    
    // MARK: - Fileprivate methods
    fileprivate func validateShouldFetchCharacterDetailSuccessfully(expectation: XCTestExpectation) {
        XCTAssertEqual(character, MockCharacter().getFirstCharacter())
        expectation.fulfill()
    }
}

// MARK: - CharacterDetailDelegate methods
extension MockCharacterDetailViewModel: CharacterDetailDelegate {
    func characterDetailWillLoad() {
        characterDetailWillLoadCalled = true
    }
    
    func characterDetailDidLoad(item: Character) {
        characterDetailDidLoadCalled = true
        character = item
    }

    func characterDetailDidFailLoad(error: Error) {
        characterDetailDidFailLoadCallled = true
    }
}
