//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import UIKit
import SwiftSpinner

class CharacterDetailViewController: UIViewController {
    // MARK: - Properties
    var viewModel: CharacterDetailViewModel?

    // MARK: - IBOutlets
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var movieView: UIView!
    @IBOutlet private weak var movieLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewModel()
    }
    
    // MARK: - IBAction methods
    @IBAction func actionWikiMoreInfo(_ sender: UISegmentedControl) {
     
    }
    
    // MARK: - Private methods
    private func loadViewModel() {
        viewModel?.fetchCharacterDetail()
    }
}

// MARK: - CharacterDetailDelegate methods
extension CharacterDetailViewController: CharacterDetailDelegate {
    func characterDetailWillLoad() {
        SwiftSpinner.show(NSLocalizedString("loading", comment: ""))
    }
    
    func characterDetailDidLoad(item: Character) {
        headerLabel.text = item.name
        characterImageView.sd_setImage(with: URL(string: item.thumbnail.fullPath), placeholderImage: #imageLiteral(resourceName: "icon-unavailable"))
        characterImageView.rounded()
        textView.text = item.movies
        SwiftSpinner.hide()
    }

    func characterDetailDidFailLoad(error: Error) {
        print("[ERR] characterListDidFailLoad >> \(error.localizedDescription)")
        SwiftSpinner.hide()
    }
}
