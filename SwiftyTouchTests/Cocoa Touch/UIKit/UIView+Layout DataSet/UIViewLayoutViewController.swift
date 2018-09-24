//
//  UIViewLayoutViewController.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

private let swiftyTouchTestsBundle = Bundle(for: UIViewLayoutTests.self)
private let storyboardName = "UIViewLayoutStoryboard"

class UIViewLayoutViewController: UIViewController {
    
    private static let rootController: UIViewController =
        UIStoryboard(name: storyboardName, bundle: swiftyTouchTestsBundle).instantiateInitialViewController()!
    static let shared = {
        ((rootController as! UITabBarController)
            .viewControllers?.first! as! UINavigationController)
            .viewControllers.first! as! UIViewLayoutViewController
    }()
    
    @IBOutlet weak var viewConstrainedToRootView: UIView!
    @IBOutlet weak var viewConstrainedToSafeAreaRelativeMargins: UIView!
    
    @IBOutlet weak var viewWithSafeAreaLayoutGuide: UIView!
    @IBOutlet weak var viewConstrainedToSuperviewSafeArea: UIView!

    @IBOutlet weak var viewConstrainedToRootViewSafeArea: UIView!

    @IBOutlet weak var viewConstrainedToMargins: UIView!

    @IBOutlet weak var viewPreservingSuperviewMargins: UIView!
    
    @IBOutlet weak var viewFollowingReadableWidth: UIView!
    @IBOutlet weak var labelConstrainedToMargins: UILabel!
}
