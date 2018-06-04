//
//  NibConvertibleReusableViews.swift
//  XDKitTests
//
//  Created by Xavier Leporcher on 20/04/2018.
//  Copyright © 2018 EI Xavier Leporcher. All rights reserved.
//

import UIKit
import SwiftyTouch

class ValidTableViewCell: NibTableViewCell<FirstValidCustomView> {
    
    private(set) var isNibDidLoadCalled = false
    
    override func nibDidLoad() {
        super.nibDidLoad()
        isNibDidLoadCalled = true
    }
}

class ValidTableViewHeaderFooterView: NibTableViewHeaderFooterView<FirstValidCustomView> {
    
    private(set) var isNibDidLoadCalled = false
    
    override func nibDidLoad() {
        super.nibDidLoad()
        isNibDidLoadCalled = true
    }
}

class ValidCollectionViewCell: NibCollectionViewCell<FirstValidCustomView> {
    
    private(set) var isNibDidLoadCalled = false
    
    override func nibDidLoad() {
        super.nibDidLoad()
        isNibDidLoadCalled = true
    }
}

class ValidCollectionReusableView: NibCollectionReusableView<FirstValidCustomView> {
    
    private(set) var isNibDidLoadCalled = false
    
    override func nibDidLoad() {
        super.nibDidLoad()
        isNibDidLoadCalled = true
    }
}
