//
//  StoryboardObjectProvider.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

internal final class StoryboardObjectProvider {
    
    static func instantiateStoryboardViewController<V>(from storyboard: StoryboardConvertible,
                                                       storyboardIdentifier: String?) throws -> V where V: UIViewController {
        let uiStoryboard = try self.uiStoryboard(for: V.self, from: storyboard)
        if let identifier = storyboardIdentifier {
            // `instantiateViewController` asserts in case of wrong identifier
            let identifiedViewController = uiStoryboard.instantiateViewController(withIdentifier: identifier)
            guard let storyboardViewController = identifiedViewController as? V else {
                throw StoryboardError.identifiedViewControllerOfTypeNotFound(foundType: type(of: identifiedViewController),
                                                                             identifier: identifier, for: V.self)
            }
            return storyboardViewController
        } else {
            guard let initialViewController = uiStoryboard.instantiateInitialViewController() else {
                throw StoryboardError.viewControllerAsInitialNotFound(for: V.self)
            }
            guard let storyboardViewController = initialViewController as? V else {
                throw StoryboardError.initialViewControllerOfTypeNotFound(foundType: type(of: initialViewController),
                                                                          for: V.self)
            }
            return storyboardViewController
        }
    }
}

private struct Storyboards {
    
    // Store storyboards to improve performances
    static var storyboards = [ObjectIdentifier : UIStoryboard]()
}

private extension StoryboardObjectProvider {
    
    static func uiStoryboard(for viewControllerType: UIViewController.Type,
                             from storyboard: StoryboardConvertible) throws -> UIStoryboard {
        guard let storedStoryboard = Storyboards.storyboards[ObjectIdentifier(viewControllerType)] else {
            // Safety check for `StoryboardFileConvertible`
            try (storyboard as? StoryboardFileConvertible)?.checkPath(for: viewControllerType)
            // Instantiate and store UIStoryboard
            let storedStoryboard = storyboard.storyboard
            Storyboards.storyboards[ObjectIdentifier(viewControllerType)] = storedStoryboard
            return storedStoryboard
        }
        return storedStoryboard
    }
}
