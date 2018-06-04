//
//  LoadableFromStoryboard.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

public protocol LoadableFromStoryboard {
    
    static func fromStoryboard() throws -> Self
}

// MARK: - ViewControllerLoadableFromStoryboard

public protocol ViewControllerLoadableFromStoryboard: LoadableFromStoryboard {
    
    // Note: Did not use properties because protocols and Optional cannot be inferred from literals
    static func storyboard() throws -> StoryboardConvertible
    static func storyboardIdentifier() -> String?
}

public extension ViewControllerLoadableFromStoryboard {
    
    static func storyboardIdentifier() -> String? {
        return nil
    }
}
