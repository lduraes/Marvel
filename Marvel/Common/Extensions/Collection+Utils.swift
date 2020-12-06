//
//  Collection+Utils.swift
//  Marvel
//
//  Created by Luiz Durães on 02/09/2020.
//  Copyright © 2020 Luiz Durães. All rights reserved.
//

import Foundation

extension Collection {
    var customEnumeration: Zip2Sequence<PartialRangeFrom<Int32>, Self> { zip(1..., self) }
}
