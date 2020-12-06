//
//  CharacterListViewModelTest.swift
//  MarvelTests
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import XCTest
@testable import Marvel

class CharacterListViewModelTest: XCTestCase {
    // MARK: - Properties
    private weak var delegate: MockCharacterListViewModel?
    private var provider: MockCharacterProvider!
    fileprivate var viewModel: CharacterListViewModel!
    
    override func setUp() {
        super.setUp()
        delegate = MockCharacterListViewModel()
        provider = MockCharacterProvider()
        viewModel = CharacterListViewModel(delegate: delegate, provider: provider)
    }
    
    override func tearDown() {
        super.tearDown()
        delegate = nil
        provider = nil
        viewModel = nil
    }
    
    func testShouldFetchCharacterListSuccessfully() {
        // given
        let successExpectation = XCTestExpectation()
        
        // when
        viewModel.fetchCharacterList()
        
        // then
        delegate?.validateShouldFetchCharacterListSuccessfully(expectation: successExpectation, dataSource: viewModel.dataSource)
    }
    
    func testShouldFailFetchCharacterList() {
        // given
        let failExpectation = XCTestExpectation()
        
        // when
        provider.simulateError = true
        viewModel.fetchCharacterList()
        
        // then
        delegate?.validateShouldFailFetchCharacterList(expectation: failExpectation, dataSource: viewModel.dataSource)
    }
    
    func testShouldRetrieveItemAtIndex() {
        // given
        let successExpectation = XCTestExpectation()
        
        // when
        viewModel.fetchCharacterList()
        
        // then
        delegate?.validateShouldRetrieveItemAtIndex(expectation: successExpectation, viewModel: viewModel)
    }

    func testShouldOpenExternalUrlForWebsite() {
        // given
        let successExpectation = XCTestExpectation()
        
        // when
        viewModel.fetchCharacterList()
        
        // then
        delegate?.validateShouldOpenExternalUrlForWebsite(expectation: successExpectation, viewModel: viewModel)
    }

    func testShouldOpenExternalUrlForWiki() {
        // given
        let successExpectation = XCTestExpectation()
        
        // when
        viewModel.fetchCharacterList()
        
        // then
        delegate?.validateShouldOpenExternalUrlForWiki(expectation: successExpectation, viewModel: viewModel)
    }
}

private class MockCharacterListViewModel {
    // MARK: - Properties
    private var characterListWillLoadCalled = false
    private var characterListDidLoadCalled = false
    private var characterListDidFailLoadCalled  = false

    // MARK: - Fileprivate methods
    fileprivate func validateShouldFetchCharacterListSuccessfully(expectation: XCTestExpectation, dataSource: [Character]) {
        XCTAssertTrue(characterListWillLoadCalled)
        XCTAssertTrue(characterListDidLoadCalled)
        XCTAssertFalse(characterListDidFailLoadCalled)
        XCTAssertFalse(dataSource.isEmpty)
        expectation.fulfill()
    }

    fileprivate func validateShouldFailFetchCharacterList(expectation: XCTestExpectation, dataSource: [Character]) {
        XCTAssertTrue(characterListWillLoadCalled)
        XCTAssertFalse(characterListDidLoadCalled)
        XCTAssertTrue(characterListDidFailLoadCalled)
        XCTAssertTrue(dataSource.isEmpty)
        expectation.fulfill()
    }

    fileprivate func validateShouldRetrieveItemAtIndex(expectation: XCTestExpectation, viewModel: CharacterListViewModel) {
        let characterAtIndex0 = viewModel.item(at: 0)
        XCTAssertEqual(characterAtIndex0, MockCharacter().getFirstCharacter())
        expectation.fulfill()
    }

    fileprivate func validateShouldOpenExternalUrlForWebsite(expectation: XCTestExpectation, viewModel: CharacterListViewModel) {
        viewModel.openExternalUrL(characterIndex: 1, actionTile: .website)
        expectation.fulfill()
    }

    fileprivate func validateShouldOpenExternalUrlForWiki(expectation: XCTestExpectation, viewModel: CharacterListViewModel) {
        viewModel.openExternalUrL(characterIndex: 2, actionTile: .wiki)
        expectation.fulfill()
    }
}

// MARK: - CharacterListDelegate methods
extension MockCharacterListViewModel: CharacterListDelegate {
    func characterListWillLoad() {
        characterListWillLoadCalled = true
    }
    
    func characterListDidLoad() {
        characterListDidLoadCalled = true
    }
    
    func characterListDidFailLoad(error: Error) {
        characterListDidFailLoadCalled = true
    }
}
