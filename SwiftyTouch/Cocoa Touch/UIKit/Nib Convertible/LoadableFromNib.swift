//
//  LoadableFromNib.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

public protocol LoadableFromNib {
    
    static func fromNib() throws -> Self
}

// MARK: - ViewLoadableFromNib

public protocol ViewLoadableFromNib: LoadableFromNib {
    
    // Note: Did not use properties because protocols and Optional cannot be inferred from literals
    static func nib() throws -> NibConvertible
    static func nibObjectIndex() -> Int?
    
    static func fromNib(frame: CGRect?) throws -> Self
    
    func nibDidLoad()
}

public extension ViewLoadableFromNib {
    
    static func nibObjectIndex() -> Int? {
        return nil
    }
}

// MARK: - ViewControllerLoadableFromNib

public protocol ViewControllerLoadableFromNib: LoadableFromNib {
    
    // Note: Did not use properties because protocols and Optional cannot be inferred from literals
    static func nibFile() throws -> NibFileConvertible
}

// MARK: - SuperviewLoadableFromNib

public protocol SuperviewLoadableFromNib {
    
    associatedtype NibView: UIView, ViewLoadableFromNib
    
    var nibView: NibView? { get }
    
    func nibDidLoad()
}

public extension SuperviewLoadableFromNib {
    
    public func nibDidLoad() { }
}
