//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterListTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func configure(character: Character) {
        characterImageView.sd_setImage(with: URL(string: character.thumbnail.fullPath), placeholderImage: #imageLiteral(resourceName: "icon-unavailable"))
        characterImageView.rounded()
        nameLabel.text = character.name
        descriptionLabel.text = character.description
    }
}
