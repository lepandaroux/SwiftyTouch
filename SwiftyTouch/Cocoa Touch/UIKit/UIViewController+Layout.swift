//
//  UIViewController+Layout.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func addSubviewController(_ viewController: UIViewController,
                              in containerView: UIView) {
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func addSubviewController(_ viewController: UIViewController,
                              scaledToFill containerView: UIView,
                              constainToLayoutGuides: Bool = true) {
        addChildViewController(viewController)
        containerView.addSubview(scaledToFill: viewController.view,
                                 constainToLayoutGuides: constainToLayoutGuides)
        viewController.didMove(toParentViewController: self)
    }
    
    func addSubviewController(_ viewController: UIViewController,
                              in containerView: UIView,
                              inset: UIEdgeInsets,
                              constainToLayoutGuides: Bool = true) {
        addChildViewController(viewController)
        containerView.addSubview(viewController.view,
                                 inset: inset,
                                 constainToLayoutGuides: constainToLayoutGuides)
        viewController.didMove(toParentViewController: self)
    }
    
    func removeFromSuperviewController() {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}
