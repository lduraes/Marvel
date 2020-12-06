//
//  UIViewController+Utils.swift
//  Marvel
//
//  Created by Luiz Duraes on 01/09/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import UIKit
import Router

enum AlertActionTitle {
    case website
    case wiki
    case cancel
}

extension UIViewController {
    func navigate(_ navigation: NavigationItem) {
        navigate(navigation as Navigation)
    }
    
    func showAlert(title: String, message: String, firstActionTitle: String, secondActionTitle: String, completion: @escaping (_ result: AlertActionTitle) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: firstActionTitle, style: .default, handler: { _ in
            completion(.website)
        }))
        
        alert.addAction(UIAlertAction(title: secondActionTitle, style: .default, handler: { _ in
            completion(.wiki)
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("navigationCancelActionTitle", comment: ""), style: .cancel, handler: { _ in
            completion(.cancel)
        }))
    }
}
