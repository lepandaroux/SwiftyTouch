//
//  NibOwnerView.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

// MARK: - NibOwnerView

/**
 View built as the *File's Owner* of a `UIView` in a nib.
 ## Usage:
 ### Code side
 1. Adopt this *protocol* from a `final` `UIView` class.
 2. Implement required function `nib()`.
 3. Optionally implement function `nibObjectIndex()`.
 ### Nib side
 1. Create a `UIView` in your nib file.
 2. Set the *File's Owner* of your nib file to your class.
 ### Available initializers
 - `fromNib()`
 - `fromNib(frame:)`
 - `init(fromNibWithFrame:)`
 ## Lifecycle
 The `nibDidLoad()` function is called after the view has loaded its nib.
 You usually implement this function to perform additional initialization on subviews.
 */
public protocol NibOwnerView: ViewLoadableFromNib { }

public extension NibOwnerView where Self: UIView {
    
    static func fromNib() throws -> Self {
        return try fromNib(frame: nil)
    }
    
    public static func fromNib(frame: CGRect?) throws -> Self {
        return try self.init(fromNibWithFrame: frame)
    }
    
    public init(fromNibWithFrame frame: CGRect?) throws {
        self.init(frame: frame ?? .zero)
        let view = try NibObjectProvider.instantiateNibView(withOwnerView: self,
                                                            from: Self.nib(),
                                                            nibObjectIndex: Self.nibObjectIndex())
        if let frame = frame {
            view.frame = frame
        } else {
            bounds.size = view.frame.size
        }
        addSubviewConstrained(view)
        nibDidLoad()
    }
    
    func nibDidLoad() { }
}
