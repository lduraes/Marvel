//
//  AppRouter.swift
//  Marvel
//
//  Created by Luiz Duraes on 01/09/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import UIKit
import Router

enum NavigationItem: Navigation {
    case list
    case detail(Character)
}

struct AppRouter: AppNavigation {
    private let mainStoryBoard = UIStoryboard(name: AppConfig.Storyboard.main, bundle: nil)
    
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        if let navigation = navigation as? NavigationItem {
            switch navigation {
            case .list:
                if let viewController = mainStoryBoard.instantiateViewController(withIdentifier: String(describing: CharacterListViewController.self)) as? CharacterListViewController {
                    return viewController
                }
            case .detail(let character):
                if let viewController = mainStoryBoard.instantiateViewController(withIdentifier: String(describing: CharacterDetailViewController.self)) as? CharacterDetailViewController {
                    let viewModel = CharacterDetailViewModel(delegate: viewController, model: character) 
                    viewController.viewModel = viewModel
                    return viewController
                }
            }
        }
        
        return UIViewController()
    }
    
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
}
