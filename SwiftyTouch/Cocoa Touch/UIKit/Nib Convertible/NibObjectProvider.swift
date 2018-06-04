//
//  NibObjectProvider.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

internal final class NibObjectProvider {
    
    static func instantiateNibView<V>(withOwnerType type: V.Type,
                                      from nib: NibConvertible,
                                      nibObjectIndex: Int?) throws -> V where V: UIView {
        return try instantiateNibObject(withOwner: type,
                                        ofType: type,
                                        from: nib,
                                        nibObjectIndex: nibObjectIndex)
    }
    
    static func instantiateNibView(withOwnerView instance: UIView,
                                   from nib: NibConvertible,
                                   nibObjectIndex: Int?) throws -> UIView {
        return try instantiateNibObject(withOwner: instance,
                                        ofType: type(of: instance),
                                        from: nib,
                                        nibObjectIndex: nibObjectIndex)
    }
    
    static func instantiateNibViewController<VC>(withOwnerType type: VC.Type,
                                                 from nib: NibConvertible,
                                                 nibObjectIndex: Int?) throws -> VC where VC: UIViewController {
        return try instantiateNibObject(withOwner: type,
                                        ofType: type,
                                        from: nib,
                                        nibObjectIndex: nibObjectIndex)
    }
    
    static func instantiateNibView(withOwnerViewController instance: UIViewController,
                                   from nib: NibConvertible,
                                   nibObjectIndex: Int?) throws -> UIView {
        return try instantiateNibObject(withOwner: instance,
                                        ofType: type(of: instance),
                                        from: nib,
                                        nibObjectIndex: nibObjectIndex)
    }
}

private struct Nibs {
    
    // Store nibs to improve performances
    static var nibs = [ObjectIdentifier : UINib]()
}

private extension NibObjectProvider {
    
    static func uiNib(for ownerType: Any.Type, from nib: NibConvertible) throws -> UINib {
        guard let storedNib = Nibs.nibs[ObjectIdentifier(ownerType)] else {
            // Safety check for `NibFileConvertible`,
            // Prevent an instantiate(withOwner:options:) call from crashing.
            try (nib as? NibFileConvertible)?.checkPath(for: ownerType)
            // Instantiate and store UINib
            let storedNib = nib.nib
            Nibs.nibs[ObjectIdentifier(ownerType)] = storedNib
            return storedNib
        }
        return storedNib
    }
    
    static func instantiateNibObject<V>(withOwner owner: Any?,
                                        ofType ownerType: Any.Type,
                                        from nib: NibConvertible,
                                        nibObjectIndex: Int?) throws -> V {
        let nibObjects = try uiNib(for: ownerType, from: nib).instantiate(withOwner: owner, options: nil)
        if let index = nibObjectIndex {
            guard nibObjects.indices.contains(index) else {
                throw NibError.nibObjectAtIndexNotFound(index: index, for: ownerType)
            }
            let nibObject = nibObjects[index]
            guard let nibView = nibObject as? V else {
                throw NibError.indexedNibObjectOfTypeNotFound(foundType: type(of: nibObject),
                                                              expectedType: V.self,
                                                              index: index,
                                                              for: ownerType)
            }
            return nibView
        } else {
            guard let nibView = nibObjects.first(where: { $0 is V }) as? V else {
                throw NibError.nibObjectOfTypeNotFound(expectedType: V.self, for: ownerType)
            }
            return nibView
        }
    }
}
