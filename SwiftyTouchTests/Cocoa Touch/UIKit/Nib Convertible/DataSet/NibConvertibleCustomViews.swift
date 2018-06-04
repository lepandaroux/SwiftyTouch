//
//  NibConvertibleValidCustomViews.swift
//  XDKitTests
//
//  Created by Xavier Leporcher on 30/03/2018.
//  Copyright © 2018 EI Xavier Leporcher. All rights reserved.
//

import UIKit
import SwiftyTouch

private let swiftyTouchTestsBundle = Bundle(for: FirstValidCustomView.self)
private let nibName = "NibConvertibleCustomViews"

final class FirstValidCustomView: UIView, NibCustomView {
    
    static func nib() throws -> NibConvertible {
        return NibFile(nibName, bundle: swiftyTouchTestsBundle)
    }
    
    @IBOutlet weak var outlet: UIButton!
    @IBOutlet weak var indexLabel: UILabel!
    
    private(set) var isNibDidLoadCalled = false
    
    func nibDidLoad() {
        isNibDidLoadCalled = true
    }
}

final class IndexedValidCustomView: UIView, NibCustomView {
    
    static func nib() throws -> NibConvertible {
        return NibFile(nibName, bundle: swiftyTouchTestsBundle)
    }
    static func nibObjectIndex() -> Int? { return 1 }
    
    @IBOutlet weak var outlet: UIButton!
    @IBOutlet weak var indexLabel: UILabel!

    private(set) var isNibDidLoadCalled = false
    
    func nibDidLoad() {
        isNibDidLoadCalled = true
    }
}

final class NotIndexedValidCustomView: UIView, NibCustomView {
    
    static func nib() throws -> NibConvertible {
        return NibFile(nibName, bundle: swiftyTouchTestsBundle)
    }
    
    @IBOutlet weak var outlet: UIButton!
    @IBOutlet weak var indexLabel: UILabel!

    private(set) var isNibDidLoadCalled = false
    
    func nibDidLoad() {
        isNibDidLoadCalled = true
    }
}
