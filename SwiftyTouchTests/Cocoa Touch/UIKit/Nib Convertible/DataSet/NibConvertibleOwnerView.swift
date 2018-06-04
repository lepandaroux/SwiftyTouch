//
//  NibConvertibleValidOwnerView.swift
//  XDKitTests
//
//  Created by Xavier Leporcher on 30/03/2018.
//  Copyright © 2018 EI Xavier Leporcher. All rights reserved.
//

import UIKit
import SwiftyTouch

private let swiftyTouchTestsBundle = Bundle(for: FirstValidCustomView.self)
private let nibName = "NibConvertibleOwnerView"

final class ValidOwnerView: UIView, NibOwnerView {
    
    static func nib() throws -> NibConvertible {
        return NibFile(nibName, bundle: swiftyTouchTestsBundle)
    }

    @IBOutlet weak var outlet: UIButton!
    
    private(set) var isNibDidLoadCalled = false
    
    func nibDidLoad() {
        isNibDidLoadCalled = true
    }
}
