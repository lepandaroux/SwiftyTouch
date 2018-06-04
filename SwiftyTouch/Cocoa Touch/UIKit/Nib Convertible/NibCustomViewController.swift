//
//  NibCustomViewController.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

// MARK: - NibCustomViewController

/**
 View Controller built as the *Custom Class* of a `UIViewController` in a nib.
 ## Usage:
 ### Code side
 1. Adopt this *protocol* from a `final` `UIViewController` class.
 2. Implement required function `nibFile()`.
 3. Optionally implement function `nibObjectIndex()`.
 ### Nib side
 1. Create a `UIViewController` in your nib file.
 2. Set its *Custom Class* to your class.
 ### Available initializers
 - `fromNib()`
 */
public protocol NibCustomViewController: ViewControllerLoadableFromNib {
    
    static func nibObjectIndex() -> Int?
}

public extension NibCustomViewController {
    
    static func nibObjectIndex() -> Int? {
        return nil
    }
}

public extension NibCustomViewController where Self: UIViewController {
    
    public static func fromNib() throws -> Self {
        return try NibObjectProvider.instantiateNibViewController(withOwnerType: self,
                                                                  from: nibFile(),
                                                                  nibObjectIndex: nibObjectIndex())
    }
}
