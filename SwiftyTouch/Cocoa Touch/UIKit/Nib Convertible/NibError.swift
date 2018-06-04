//
//  NibError.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

public enum NibError: Error {
    
    case nibFileNotFound(name: String, bundle: Bundle, for: Any.Type)
    case nibObjectOfTypeNotFound(expectedType: Any.Type, for: Any.Type)
    case nibObjectAtIndexNotFound(index: Int, for: Any.Type)
    case indexedNibObjectOfTypeNotFound(foundType: Any.Type, expectedType: Any.Type, index: Int, for: Any.Type)
    case classNotInherited(AnyClass)
    case functionNibNotOverridden(for: AnyClass, baseClass: AnyClass)
    case functionNibFileNotOverridden(for: AnyClass, baseClass: AnyClass)
}

extension NibError: CustomStringConvertible {
    
    public var description: String {
        var message = "[\(type(of: self))]"
        switch self {
            
        case let .nibFileNotFound(name, bundle, type):
            message += " '\(type)':"
            message += " Nib file with name '\(name)' not found in bundle '\(bundle)'."
            return message
            
        case let .nibObjectOfTypeNotFound(expectedType, type):
            message += " '\(type)':"
            message += " Object of type '\(expectedType)' not found in nib."
            if expectedType != UIView.self && expectedType != UIViewController.self {
                message += " Did you set the Custom Class of your object from the nib?"
            }
            return message
            
        case let .nibObjectAtIndexNotFound(index, type):
            message += " '\(type)':"
            message += " No object exists at index \(String(index)) in nib."
            return message
            
        case let .indexedNibObjectOfTypeNotFound(foundType, expectedType, index, type):
            message += " '\(type)':"
            message += " Object of type '\(expectedType)' not found at index \(String(index)) in nib."
            message += " '\(foundType)' was found instead."
            if expectedType != UIView.self && expectedType != UIViewController.self {
                message += " Did you set the right Custom Class of your object from the nib?"
            }
            return message
            
        case let .classNotInherited(type):
            message += " '\(type)':"
            message += " This class should not be used directly. Inherit it instead."
            return message
            
        case let .functionNibNotOverridden(type, baseClass):
            message += " '\(type)':"
            message += " This class"
            if type.superclass() != baseClass { message += " or one of its superclass" }
            message += " should provide its own implementation of `nib()`."
            return message
            
        case let .functionNibFileNotOverridden(type, baseClass):
            message += " '\(type)':"
            message += " This class"
            if type.superclass() != baseClass { message += " or one of its superclass" }
            message += " should provide its own implementation of `nibFile()`."
            return message
        }
    }
}
