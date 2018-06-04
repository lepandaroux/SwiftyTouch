//
//  StoryboardViewController.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

// MARK: - StoryboardViewController

/**
 View Controller built as the *Custom Class* of a `UIViewController` in a storyboard.
 ## Usage:
 ### Code side
 1. Adopt this *protocol* from a `final` `UIViewController` class.
 2. Implement required function `storyboard()`.
 3. Optionally implement function `storyboardIdentifier()`.
 ### Storyboard side
 1. Create a `UIViewController` in your storyboard file.
 2. Set its *Custom Class* to your class.
 3. If not already done for another `UIViewController` of the storyboard,
 - Make your `UIViewController` the *Initial View Controller* of the storyboard.
 - Otherwise, set your `UIViewController`'s *Storyboard ID* to the value returned from the function `storyboardIdentifier()`. Implementation of the last is so required.
 ### Available initializers
 - `fromStoryboard()`
 */
public protocol StoryboardViewController: ViewControllerLoadableFromStoryboard { }

public extension StoryboardViewController where Self: UIViewController {
    
    static func fromStoryboard() throws -> Self {
        return try StoryboardObjectProvider
            .instantiateStoryboardViewController(from: storyboard(),
                                                 storyboardIdentifier: storyboardIdentifier())
    }
}
