//
//  StoryboardError.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

public enum StoryboardError: Error {
    
    case storyboardFileNotFound(name: String, bundle: Bundle, for: Any.Type)
    case viewControllerAsInitialNotFound(for: UIViewController.Type)
    case viewControllerIdentifierNotFound(identifier: String, for: UIViewController.Type)
    case initialViewControllerOfTypeNotFound(foundType: UIViewController.Type, for: UIViewController.Type)
    case identifiedViewControllerOfTypeNotFound(foundType: UIViewController.Type, identifier: String, for: UIViewController.Type)
}

extension StoryboardError: CustomStringConvertible {
    
    public var description: String {
        var message = "[\(type(of: self))]"
        switch self {
            
        case let .storyboardFileNotFound(name, bundle, type):
            message += " '\(type)':"
            message += " Storyboard file with name '\(name)' not found in bundle '\(bundle)'."
            return message
            
        case let .viewControllerAsInitialNotFound(type):
            message += " '\(type)':"
            message += " View controller as initial one not found in storyboard."
            message += " Did you set the Initial View Controller of the storyboard?"
            message += " Or forget to implement `storyboardIdentifier()` on '\(type)'?"
            return message
            
        case let .viewControllerIdentifierNotFound(identifier, type):
            message += " '\(type)':"
            message += " View controller with identifier '\(identifier)' not found in storyboard."
            message += " Did you set this identifier as the Storyboard ID of your view controller?"
            return message
            
        case let .initialViewControllerOfTypeNotFound(foundType, type):
            message += " '\(type)':"
            message += " Initial view controller of type '\(type)' not found in storyboard."
            message += " '\(foundType)' was found instead."
            if foundType == UIViewController.self {
                message += " Did you set the Custom Class of your view controller?"
            } else {
                message += " Did you set the Initial View Controller to this view controller?"
            }
            message += " Or forget to implement `storyboardIdentifier()` on '\(type)'?"
            return message
            
        case let .identifiedViewControllerOfTypeNotFound(foundType, identifier, type):
            message += " '\(type)':"
            message += " View controller of type '\(type)' with identifier '\(identifier)' not found in storyboard."
            message += " '\(foundType)' was found instead."
            if foundType == UIViewController.self {
                message += " Did you set the Custom Class of your view controller?"
            } else {
                message += " Did you set the right identifier as the Storyboard ID of your view controller?"
            }
            return message
        }
    }
}
