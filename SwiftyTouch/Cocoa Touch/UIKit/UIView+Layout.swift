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
        while let responderView = responder as? UIView {
            responder = responderView.next
        }
        return responder as? UIViewController
    }

    public enum SubviewGuide {

        /// The bounds of the superview, without any specific guide.
        case superview

        /// The safe area provided by UIKit.
        case safeArea

        /**
            The layout margins provided by UIKit.
         
            To adjust margins, consider the following properties:
         
            # directionalLayoutMargins
            UIKit provides default layout margins for each view. To change the default values, update the view’s `directionalLayoutMargins` property. (You can also use the Size inspector to set the value of that property at design time.) Use `layoutMargins` prior to iOS 11.
         
                self.directionalLayoutMargins
         
            # insetsLayoutMarginsFromSafeArea
            The view's layout margins are updated automatically to reflect the safe area.
            Any margins that are outside the safe area are automatically modified to fall within the safe area boundary. Changing the value to `false` allows your margins to remain at their original locations, even when they are outside the safe area.
         
                // Defaults to `true`
                self.insetsLayoutMarginsFromSafeArea
         
            # preservesSuperviewLayoutMargins
            The view also respects the margins of its superview.
            For example, you might have a content view whose frame precisely matches the bounds of its superview. When any of the superview’s margins is inside the area represented by the content view and its own margins, UIKit adjusts the content view’s layout to respect the superview’s margins.
         
                // Defaults to `false`
                self.preservesSuperviewLayoutMargins
         
            # viewRespectsSystemMinimumLayoutMargins
            For the root view of a view controller, UIKit enforces a set of minimum layout margins to ensure that content is displayed correctly. When the values in the `directionalLayoutMargins` property are less than the minimum values, UIKit uses the minimum values instead. You can get the minimum margin values from the `systemMinimumLayoutMargins` property of the view controller. To prevent UIKit from applying the minimum margins altogether, set the `viewRespectsSystemMinimumLayoutMargins` property of your view controller to `false`.
         
                // Defaults to `true`
                viewController.viewRespectsSystemMinimumLayoutMargins
         */
        case margins
        
        /**
            The readable content guide provided by UIKit.
         
            Preserve a max width to maintain not too long lines of text.
            This layout guide defines an area that can easily be read without forcing users to move their head to track the lines. The readable content area follows the following rules:
            - The readable content guide never extends beyond the view’s layout margin guide.
            - The readable content guide is vertically centered inside the layout margin guide.
            - The readable content guide’s width is equal to or less than the readable width defined for the current dynamic text size.
         
            Use the readable content guide to lay out a single column of text. If you are laying out multiple columns, you can use the guide’s width to determine the optimal width for your columns.
         
            This behavior is called `Follow Readable Width` at design time.
         */
        case readableContent
        
        /**
            A custom layout guide.
         
            Add your custom layout guide to its owning view before using it.
         
            See: https://developer.apple.com/documentation/uikit/uiview/1622414-addlayoutguide
         */
        case custom(UILayoutGuide)
    }

    func addSubviewConstrained(_ view: UIView,
                               relativeTo guide: SubviewGuide = .superview,
                               inset: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        constrainSubview(view, relativeTo: guide, inset: inset)
    }
    
    func insertSubviewConstrained(_ view: UIView,
                                  at index: Int,
                                  relativeTo guide: SubviewGuide = .superview,
                                  inset: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(view, at: index)
        constrainSubview(view, relativeTo: guide, inset: inset)
    }
    
    func insertSubviewConstrained(_ view: UIView,
                                  belowSubview siblingSubview: UIView,
                                  relativeTo guide: SubviewGuide = .superview,
                                  inset: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(view, belowSubview: siblingSubview)
        constrainSubview(view, relativeTo: guide, inset: inset)
    }
    
    func insertSubviewConstrained(_ view: UIView,
                                  aboveSubview siblingSubview: UIView,
                                  relativeTo guide: SubviewGuide = .superview,
                                  inset: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(view, aboveSubview: siblingSubview)
        constrainSubview(view, relativeTo: guide, inset: inset)
    }
    
    private func constrainSubview(_ view: UIView,
                                  relativeTo guide: SubviewGuide,
                                  inset: UIEdgeInsets) {
        let anchors: (top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor,
                      bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor)
        switch guide {
        case .superview:
            anchors = (topAnchor, leadingAnchor, bottomAnchor, trailingAnchor)
        case .safeArea:
            if #available(iOS 11.0, *) {
                anchors = (safeAreaLayoutGuide.topAnchor, safeAreaLayoutGuide.leadingAnchor,
                           safeAreaLayoutGuide.bottomAnchor, safeAreaLayoutGuide.trailingAnchor)
            } else {
                guard let selfVC = parentViewController, self == selfVC.view else {
                    anchors = (topAnchor, leadingAnchor, bottomAnchor, trailingAnchor)
                    break
                }
                anchors = (selfVC.topLayoutGuide.bottomAnchor, leadingAnchor,
                           selfVC.bottomLayoutGuide.topAnchor, trailingAnchor)
            }
        case .margins:
            anchors = (layoutMarginsGuide.topAnchor, layoutMarginsGuide.leadingAnchor,
                       layoutMarginsGuide.bottomAnchor, layoutMarginsGuide.trailingAnchor)
        case .readableContent:
            anchors = (readableContentGuide.topAnchor, readableContentGuide.leadingAnchor,
                       readableContentGuide.bottomAnchor, readableContentGuide.trailingAnchor)
        case let .custom(guide):
            anchors = (guide.topAnchor, guide.leadingAnchor, guide.bottomAnchor, guide.trailingAnchor)
        }
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchors.top, constant: inset.top), // top
            view.leadingAnchor.constraint(equalTo: anchors.leading, constant: inset.left), // leading
            anchors.bottom.constraint(equalTo: view.bottomAnchor, constant: inset.bottom), // bottom
            anchors.trailing.constraint(equalTo: view.trailingAnchor, constant: inset.right) // trailing
            ])
    }
}
