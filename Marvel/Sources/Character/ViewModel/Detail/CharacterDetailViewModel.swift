//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

protocol CharacterDetailDelegate: AnyObject {
    func characterDetailWillLoad()
    func characterDetailDidLoad(item: Character)
    func characterDetailDidFailLoad(error: Error)
}

final class CharacterDetailViewModel {
    // MARK: - Properties
    private weak var delegate: CharacterDetailDelegate?
    private(set) var model: Character

    // MARK: - Initializers
    init(delegate: CharacterDetailDelegate?, model: Character) {
        self.delegate = delegate
        self.model = model
    }
    
    // MARK: - Public methods
    func fetchCharacterDetail() {
        delegate?.characterDetailWillLoad()
        delegate?.characterDetailDidLoad(item: model)
    }
}
