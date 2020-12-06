//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterListDelegate: AnyObject {
    func characterListWillLoad()
    func characterListDidLoad()
    func characterListDidFailLoad(error: Error)
}

final class CharacterListViewModel {
    // MARK: - Constants
    private let itemsPerRequest = 10
    
    // MARK: - Properties
    private weak var delegate: CharacterListDelegate?
    private var provider: CharacterProviderDelegate
    private var offset = 0
    private(set) var dataSource = [Character]()
    
    // MARK: - Initializers
    init(delegate: CharacterListDelegate?, provider: CharacterProviderDelegate) {
        self.delegate = delegate
        self.provider = provider
    }
    
    // MARK: - Public methods
    func fetchCharacterList() {
        delegate?.characterListWillLoad()
        
        provider.fetchCharacterList(offset: offset, itemsPerRequest: itemsPerRequest) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let marvel):
                self.dataSource.append(contentsOf: self.getCharacters(characterData: marvel.data))
                self.delegate?.characterListDidLoad()
            case .failure(let error):
                self.delegate?.characterListDidFailLoad(error: error)
            }
        }
        
        offset += itemsPerRequest
    }
    
    func item(at index: Int) -> Character {
        return dataSource[index]
    }
    
    func openExternalUrL(characterIndex: Int, actionTile: AlertActionTitle) {
        let character = item(at: characterIndex)
        
        switch actionTile {
        case .website:
            guard let url = character.detailUrl else { return }
            UIApplication.shared.open(url)
        case .wiki:
            guard let url = character.wikiUrl else { return }
            UIApplication.shared.open(url)
        default:
            break
        }
    }
    
    // MARK: - Private methods
    private func getCharacters(characterData: CharacterData) -> [Character] {
        return characterData.results
    }
}
