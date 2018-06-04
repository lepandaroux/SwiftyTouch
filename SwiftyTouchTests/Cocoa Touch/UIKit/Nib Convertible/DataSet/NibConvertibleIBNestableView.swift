//
//  NibConvertibleIBNestableView.swift
//  XDKitTests
//
//  Created by Xavier Leporcher on 10/04/2018.
//  Copyright © 2018 EI Xavier Leporcher. All rights reserved.
//

import UIKit
import SwiftyTouch

private let swiftyTouchTestsBundle = Bundle(for: ValidIBNestableView.self)
private let nibName = "NibConvertibleIBNestableView"

class ValidIBNestableView: NibIBNestableView {
    
    override static func nib() throws -> NibConvertible {
        return NibFile(nibName, bundle: swiftyTouchTestsBundle)
    }
    
    @IBOutlet weak var outlet: UIButton!
    
    private(set) var isNibDidLoadCalled = false
    
    override func nibDidLoad() {
        isNibDidLoadCalled = true
    }
}
