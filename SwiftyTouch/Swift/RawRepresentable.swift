//
//  RawRepresentable.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 29/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

public extension RawRepresentable where Self: Hashable {
    
    @available(swift, obsoleted: 4.2, message: "Swift 4.2 introduces the `CaseIterable` protocol; prefer using the last.")
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
    
    @available(swift, obsoleted: 4.2, message: "Swift 4.2 introduces the `CaseIterable` protocol; prefer using the last.")
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
