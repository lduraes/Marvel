//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Luiz Durães on 29/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import UIKit
import SwiftSpinner
import Router

class CharacterListViewController: UIViewController {
    // MARK: - Constants
    private let minimumPressDuration: TimeInterval = 0.5
    
    // MARK: - Properties
    private lazy var viewModel: CharacterListViewModel = {
        let viewModel = CharacterListViewModel(delegate: self, provider: CharacterProvider())
        return viewModel
    }()

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableViewLongPress()
        loadViewModel()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func loadViewModel() {
        viewModel.fetchCharacterList()
    }
    
    private func setupTableViewLongPress() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = minimumPressDuration
        tableView.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        if let indexPath = tableView.indexPathForRow(at: longPressGesture.location(in: tableView)),
            longPressGesture.state == UIGestureRecognizer.State.began {
            
            showAlert(title: NSLocalizedString("defaultAlertTitle", comment: ""),
                      message: NSLocalizedString("navigationAlertMessage", comment: ""),
                      firstActionTitle: NSLocalizedString("navigationFirstActionTitle", comment: ""),
                      secondActionTitle: NSLocalizedString("navigationSecondActionTitle", comment: "")) { [weak self] (actionTitleSelected) in
                        self?.viewModel.openExternalUrL(characterIndex: indexPath.row,
                                                        actionTile: actionTitleSelected)
               }
        } else {
            print("[ERR] Long press on table view, not a row!")
        }
    }
}

// MARK: - CharacterListDelegate methods
extension CharacterListViewController: CharacterListDelegate {
    func characterListWillLoad() {
        SwiftSpinner.show(NSLocalizedString("loading", comment: ""))
    }
    
    func characterListDidLoad() {
        tableView.reloadData()
        SwiftSpinner.hide()
    }

    func characterListDidFailLoad(error: Error) {
        print("[ERR] characterListDidFailLoad >> \(error.localizedDescription)")
        SwiftSpinner.hide()
    }
}

// MARK: - UITableViewDataSource methods
extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterListTableViewCell.self), for: indexPath) as? CharacterListTableViewCell {
            cell.configure(character: viewModel.item(at: indexPath.row))
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate methods
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigate(.detail(viewModel.item(at: indexPath.row)))
    }
}

// MARK: - UITableViewDataSourcePrefetching methods
extension CharacterListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last,
            lastIndexPath.row >= (viewModel.dataSource.count - 1) {
            loadViewModel()
        }
    }
}
