//
//  Weak.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 29/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

public struct Weak<T> where T: AnyObject {
    
    public private(set) weak var `weak`: T?
    
    public init(_ reference: T) {
        weak = reference
    }
}
