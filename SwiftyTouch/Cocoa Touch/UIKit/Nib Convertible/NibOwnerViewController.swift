//
//  NibOwnerViewController.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

// MARK: - NibOwnerViewController

/**
 View Controller built as the *File's Owner* of a `UIView` in a nib.
 ## Usage:
 ### Code side
 1. Adopt this *protocol* from a `final` `UIViewController` class.
 2. Implement required function `nibFile()`.
 ### Nib side
 1. Create a `UIView` in your nib file.
 2. Set the *File's Owner* of your nib file to your class.
 3. Connect the `view` outlet of your `UIViewController` to the `UIView` in your nib file.
 ### Available initializers
 - `fromNib()`
 */
public protocol NibOwnerViewController: ViewControllerLoadableFromNib { }

public extension NibOwnerViewController where Self: UIViewController {
    
    public static func fromNib() throws -> Self {
        let nibFile = try self.nibFile()
        try nibFile.checkPath(for: self)
        return Self(nibName: nibFile.nibName, bundle: nibFile.nibBundle)
    }
}
