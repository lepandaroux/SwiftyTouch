//
//  StoryboardConvertibleViewControllers.swift
//  XDKitTests
//
//  Created by Xavier Leporcher on 28/03/2018.
//  Copyright © 2018 EI Xavier Leporcher. All rights reserved.
//

import UIKit
import SwiftyTouch

private let swiftyTouchTestsBundle = Bundle(for: InitialViewController.self)
private let storyboardName          = "StoryboardConvertibleStoryboard"
private let storyboardNoInitialName = "StoryboardConvertibleNoInitialStoryboard"

final class InitialViewController: UIViewController, StoryboardViewController {
    
    static func storyboard() throws -> StoryboardConvertible {
        return StoryboardFile(storyboardName, bundle: swiftyTouchTestsBundle)
    }

    @IBOutlet weak var outlet: UIButton!
}

final class IdentifiedViewController: UIViewController, StoryboardViewController {
    
    static func storyboard() throws -> StoryboardConvertible {
        return StoryboardFile(storyboardName, bundle: swiftyTouchTestsBundle)
    }
    static func storyboardIdentifier() -> String? { return "IdentifiedID" }

    @IBOutlet weak var outlet: UIButton!
}

final class InvalidStoryboardViewController: UIViewController, StoryboardViewController {
    
    static func storyboard() throws -> StoryboardConvertible {
        return StoryboardFile("INVALIDStoryboard", bundle: swiftyTouchTestsBundle)
    }
    static func storyboardIdentifier() -> String? { return "InvalidStoryboardID" }
}

final class MissingInitialViewController: UIViewController, StoryboardViewController {
    
    static func storyboard() throws -> StoryboardConvertible {
        return StoryboardFile(storyboardNoInitialName, bundle: swiftyTouchTestsBundle)
    }
}

final class MissingIdentifierViewController: UIViewController, StoryboardViewController {
    
    static func storyboard() throws -> StoryboardConvertible {
        return StoryboardFile(storyboardName, bundle: swiftyTouchTestsBundle)
    }
}

final class InvalidIdentifierViewController: UIViewController, StoryboardViewController {
    
    static func storyboard() throws -> StoryboardConvertible {
        return StoryboardFile(storyboardName, bundle: swiftyTouchTestsBundle)
    }
    static func storyboardIdentifier() -> String? {
        return "INVALIDIdentifierID" // Instead of "InvalidIdentifierID"
    }
}

final class WrongIdentifierViewController: UIViewController, StoryboardViewController {
    
    static func storyboard() throws -> StoryboardConvertible {
        return StoryboardFile(storyboardName, bundle: swiftyTouchTestsBundle)
    }
    static func storyboardIdentifier() -> String? {
        return IdentifiedViewController.storyboardIdentifier()
    }
}
