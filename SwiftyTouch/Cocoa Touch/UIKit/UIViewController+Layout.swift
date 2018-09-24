//
//  UIViewController+Layout.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func addSubviewController(_ childController: UIViewController,
                              subviewIn containerView: UIView) {
        addChild(childController) // If the child controller has a different parent controller, it will first be removed from its current parent.
        childController.view.removeFromSuperview()
        containerView.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
    func addSubviewController(_ childController: UIViewController,
                              subviewConstrainedIn containerView: UIView,
                              relativeTo guide: UIView.SubviewGuide = .superview,
                              inset: UIEdgeInsets = .zero) {
        addChild(childController) // If the child controller has a different parent controller, it will first be removed from its current parent.
        childController.view.removeFromSuperview()
        containerView.addSubviewConstrained(childController.view,
                                            relativeTo: guide,
                                            inset: inset)
        childController.didMove(toParent: self)
    }
    
    func removeFromSuperviewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
