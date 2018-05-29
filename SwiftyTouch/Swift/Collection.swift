//
//  Collection.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 29/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

public extension Collection {
    
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
