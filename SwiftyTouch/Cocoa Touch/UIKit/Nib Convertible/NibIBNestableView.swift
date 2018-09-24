//
//  NibIBNestableView.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

// MARK: - NibIBNestableView

/**
 View built as the *File's Owner* of a `UIView` in a nib.
 
 - Important: Usable as casted `UIView` inside **Interface Builder**!
 ## Usage:
 ### Code side
 1. Inherit this *class* with a `final` one.
 2. Override function `nib()`.
 3. Optionally override function `nibObjectIndex()`.
 ### Nib side
 1. Create a `UIView` in your nib file.
 2. Set the *File's Owner* of your nib file to your class.
 ### Available initializers
 - `fromNib()`
 - `fromNib(frame:)`
 - `init(fromNibWithFrame:)`
 - `init()`
 - `init(frame:)`
 - `init?(coder: NSCoder)`
 
 Note: When an error occurs in a non throwing initializer, it is reported in property `nibViewError`.
 ## Lifecycle
 The `nibDidLoad()` function is called after the view has loaded its nib.
 You usually override this function to perform additional initialization on subviews.
 */
open class NibIBNestableView: UIView, ViewLoadableFromNib {
    
    open class func nib() throws -> NibConvertible {
        throw NibError.functionNibNotOverridden(for: self, baseClass: NibIBNestableView.self)
    }
    
    public static func fromNib() throws -> Self {
        return try fromNib(frame: nil)
    }
    
    public static func fromNib(frame: CGRect?) throws -> Self {
        return try self.init(fromNibWithFrame: frame)
    }
    
    public private(set) var nibViewError: Error?
    
    // MARK: Initialization
    
    public required init(fromNibWithFrame frame: CGRect?) throws {
        super.init(frame: frame ?? .zero)
        try setup(frame: frame)
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        nibViewError = nonThrowingSetup(frame: nil)
    }
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        nibViewError = nonThrowingSetup(frame: bounds)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        subviews.forEach { $0.removeFromSuperview() }
        nibViewError = nonThrowingSetup(frame: bounds)
    }
    
    open func nibDidLoad() { }
}

private extension NibIBNestableView {
    
    func setup(frame: CGRect?) throws {
        guard type(of: self) != NibIBNestableView.self else {
            throw NibError.classNotInherited(NibIBNestableView.self)
        }
        let view = try NibObjectProvider.instantiateNibView(withOwnerView: self,
                                                            from: type(of: self).nib(),
                                                            nibObjectIndex: type(of: self).nibObjectIndex())
        if let frame = frame {
            view.frame = frame
        } else {
            bounds.size = view.frame.size
        }
        addSubviewConstrained(view)
        nibDidLoad()
    }
    
    func nonThrowingSetup(frame: CGRect?) -> Error? {
        do {
            try setup(frame: frame)
            return nil
        } catch {
            return error
        }
    }
}
