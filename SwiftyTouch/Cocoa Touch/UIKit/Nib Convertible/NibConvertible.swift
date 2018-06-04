//
//  NibConvertible.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

// MARK: - NibConvertible

public protocol NibConvertible {
    
    var nib: UINib { get }
}

// MARK: UINib

// UINib conforms to `NibConvertible`.

extension UINib: NibConvertible {
    
    public var nib: UINib { return self }
}

// MARK: - NibFileConvertible

/**
 * Prefer using `NibFileConvertible` instead of `NibConvertible` which is safer since its file path can be checked.
 */
public protocol NibFileConvertible: NibConvertible {
    
    var nibName: String { get }
    var nibBundle: Bundle? { get } // If the parameter is nil, the main bundle is used.
}

public extension NibFileConvertible {
    
    public var nib: UINib {
        return UINib(nibName: nibName, bundle: nibBundle)
    }
    
    public var pathExists: Bool {
        return (nibBundle ?? .main).path(forResource: nibName, ofType: "nib") != nil
    }
    
    public func checkPath(for type: Any.Type) throws {
        guard pathExists else {
            throw NibError.nibFileNotFound(name: nibName,
                                           bundle: nibBundle ?? .main,
                                           for: type)
        }
    }
}

// MARK: String

// String conforms to `NibFileConvertible`.

extension String: NibFileConvertible {
    
    public var nibName: String { return self }
    public var nibBundle: Bundle? { return nil }
}

// MARK: - NibFile

public struct NibFile: NibFileConvertible {
    
    public let nibName: String
    public let nibBundle: Bundle?
    
    public init(_ nibName: String, bundle: Bundle) {
        self.nibName = nibName
        nibBundle = bundle
    }
}

// MARK: Convenience

public extension NibFile {
    
    public init(_ nibName: String, bundleFor embeddedClass: AnyClass) {
        self.init(nibName, bundle: Bundle(for: embeddedClass))
    }
}
