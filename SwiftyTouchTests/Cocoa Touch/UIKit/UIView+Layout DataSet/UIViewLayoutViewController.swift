//
//  UIViewLayoutViewController.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

private let swiftyTouchTestsBundle = Bundle(for: UIViewLayoutTests.self)
private let viewControllerNibName = "UIViewLayoutView"

class UIViewLayoutViewController: UIViewController {
    
    init() {
        super.init(nibName: viewControllerNibName, bundle: swiftyTouchTestsBundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
