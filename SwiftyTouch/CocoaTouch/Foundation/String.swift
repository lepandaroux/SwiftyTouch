//
//  String.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 31/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import Foundation

// MARK: - Localization

public extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
