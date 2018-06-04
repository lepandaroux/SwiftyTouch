//
//  StoryboardConvertible.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

// MARK: - StoryboardConvertible

public protocol StoryboardConvertible {
    
    var storyboard: UIStoryboard { get }
}

// MARK: UIStoryboard

// UIStoryboard conforms to `StoryboardConvertible`.

extension UIStoryboard: StoryboardConvertible {
    
    public var storyboard: UIStoryboard { return self }
}

// MARK: - StoryboardFileConvertible

/**
 * Prefer using `StoryboardFileConvertible` instead of `StoryboardConvertible` which is safer since its file path can be checked.
 */
public protocol StoryboardFileConvertible: StoryboardConvertible {
    
    var storyboardName: String { get }
    var storyboardBundle: Bundle? { get } // If the parameter is nil, the main bundle is used.
}

public extension StoryboardFileConvertible {
    
    public var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    }
    
    public var pathExists: Bool {
        return (storyboardBundle ?? .main).path(forResource: storyboardName, ofType: "storyboardc") != nil
    }
    
    public func checkPath(for type: Any.Type) throws {
        guard pathExists else {
            throw StoryboardError.storyboardFileNotFound(name: storyboardName,
                                                         bundle: storyboardBundle ?? .main,
                                                         for: type)
        }
    }
}

// MARK: String

// String conforms to `StoryboardFileConvertible`.

extension String: StoryboardFileConvertible {
    
    public var storyboardName: String { return self }
    public var storyboardBundle: Bundle? { return nil }
}

// MARK: - StoryboardFile

public struct StoryboardFile: StoryboardFileConvertible {
    
    public let storyboardName: String
    public let storyboardBundle: Bundle?
    
    public init(_ storyboardName: String, bundle: Bundle) {
        self.storyboardName = storyboardName
        storyboardBundle = bundle
    }
}

// MARK: Convenience

public extension StoryboardFile {
    
    public init(_ storyboardName: String, bundleFor embeddedClass: AnyClass) {
        self.init(storyboardName, bundle: Bundle(for: embeddedClass))
    }
}
