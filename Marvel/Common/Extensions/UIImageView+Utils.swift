//
//  UIImageView+Utils.swift
//  Marvel
//
//  Created by Luiz Durães on 31/08/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func rounded() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
}
