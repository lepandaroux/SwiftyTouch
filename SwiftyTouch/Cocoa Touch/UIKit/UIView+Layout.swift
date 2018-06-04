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
                    constainToLayoutGuides: Bool = true) {
        addSubview(view, inset: UIEdgeInsets.zero,
                   constainToLayoutGuides: constainToLayoutGuides)
    }
    
    func addSubview(_ view: UIView,
                    inset: UIEdgeInsets,
                    constainToLayoutGuides: Bool = true) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let selfVC = parentViewController
        let selfTopAnchor = (self == selfVC?.view && constainToLayoutGuides ?
            selfVC!.topLayoutGuide.bottomAnchor : topAnchor)
        let selfBottomAnchor = (self == selfVC?.view && constainToLayoutGuides ?
            selfVC!.bottomLayoutGuide.topAnchor : bottomAnchor)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: selfTopAnchor, constant: inset.top), // top
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left), // left
            selfBottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom), // bottom
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.right) // right
            ])
    }
}
