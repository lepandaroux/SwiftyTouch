//
//  RawRepresentable.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 29/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

public extension RawRepresentable where Self: Hashable {
    
    public static var values: [Self] {
        var values = [Self]()
        var raw = 0
        var next = withUnsafeBytes(of: &raw) { $0.load(as: self) }
        while next.hashValue == raw {
            values.append(next)
            raw += 1
            next = withUnsafeBytes(of: &raw) { $0.load(as: self) }
        }
        return values
    }
    
    public static var rawValues: [RawValue] {
        var rawValues = [RawValue]()
        var raw = 0
        var next = withUnsafeBytes(of: &raw) { $0.load(as: self) }
        while next.hashValue == raw {
            rawValues.append(next.rawValue)
            raw += 1
            next = withUnsafeBytes(of: &raw) { $0.load(as: self) }
        }
        return rawValues
    }
}
