//
//  UIView+Layout.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

public extension UIView {
    
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while responder is UIView {
            responder = responder!.next
        }
        return responder as? UIViewController
    }
    
    func addSubview(scaledToFill view: UIView,
                    constrainToLayoutGuides: Bool = true) {
        addSubview(view, inset: UIEdgeInsets.zero,
                   constrainToLayoutGuides: constrainToLayoutGuides)
    }
    
    func addSubview(_ view: UIView,
                    inset: UIEdgeInsets,
                    constrainToLayoutGuides: Bool = true) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let selfTopAnchor: NSLayoutYAxisAnchor
        let selfLeadingAnchor: NSLayoutXAxisAnchor
        let selfBottomAnchor: NSLayoutYAxisAnchor
        let selfTrailingAnchor: NSLayoutXAxisAnchor
        if constrainToLayoutGuides, #available(iOS 11, *) {
            selfTopAnchor = safeAreaLayoutGuide.topAnchor
            selfLeadingAnchor = safeAreaLayoutGuide.leadingAnchor
            selfBottomAnchor = safeAreaLayoutGuide.bottomAnchor
            selfTrailingAnchor = safeAreaLayoutGuide.trailingAnchor
        } else if constrainToLayoutGuides, let selfVC = parentViewController, self == selfVC.view {
            selfTopAnchor = selfVC.topLayoutGuide.bottomAnchor
            selfLeadingAnchor = leadingAnchor
            selfBottomAnchor = selfVC.bottomLayoutGuide.topAnchor
            selfTrailingAnchor = trailingAnchor
        } else {
            selfTopAnchor = topAnchor
            selfLeadingAnchor = leadingAnchor
            selfBottomAnchor = bottomAnchor
            selfTrailingAnchor = trailingAnchor
        }
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: selfTopAnchor, constant: inset.top), // top
            view.leadingAnchor.constraint(equalTo: selfLeadingAnchor, constant: inset.left), // leading
            selfBottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom), // bottom
            selfTrailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.right) // trailing
            ])
    }
}
