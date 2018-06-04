//
//  NibReusableView.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

// MARK: - UITableView Reusable Views

// MARK: NibTableViewCell

/**
 Table View Cell built as the superview of a `UIView` in a nib.
 
 ## Usage:
 ### Code side
 1. Inherit this generic *class* with a `ViewLoadableFromNib` as parameter type.
 
 Note: The nib loading is already defined by the `ViewLoadableFromNib` type.
 ### Available initializers
 - `init(style:, reuseIdentifier:)`
 - `init(frame:)`
 - `init?(coder: NSCoder)`
 
 Note: When an error occurs during initialization, it is reported in property `nibViewError`.
 ## Lifecycle
 The `nibDidLoad()` function is called after the view has loaded its nib.
 You usually override this function to perform additional initialization on subviews.
 */
open class NibTableViewCell<V>: UITableViewCell, SuperviewLoadableFromNib where V: UIView & ViewLoadableFromNib {
    
    public private(set) var nibView: V?
    public private(set) var nibViewError: Error?
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView.subviews.forEach { $0.removeFromSuperview() }
        setup()
    }
    
    private func setup() {
        nibViewError = nonThrowingSetup(nibViewKeyPath: \.nibView, addNibViewIn: contentView)
    }
    
    open func nibDidLoad() { }
}

// MARK: NibTableViewHeaderFooterView

/**
 Table View Header/Footer View built as the superview of a `UIView` in a nib.
 
 ## Usage:
 ### Code side
 1. Inherit this generic *class* with a `ViewLoadableFromNib` as parameter type.
 
 Note: The nib loading is already defined by the `ViewLoadableFromNib` type.
 ### Available initializers
 - `init(reuseIdentifier:)`
 - `init(frame:)`
 - `init?(coder: NSCoder)`
 
 Note: When an error occurs during initialization, it is reported in property `nibViewError`.
 ## Lifecycle
 The `nibDidLoad()` function is called after the view has loaded its nib.
 You usually override this function to perform additional initialization on subviews.
 */
open class NibTableViewHeaderFooterView<V>: UITableViewHeaderFooterView, SuperviewLoadableFromNib where V: UIView & ViewLoadableFromNib {
    
    public private(set) var nibView: V?
    public private(set) var nibViewError: Error?
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        subviews.forEach { $0.removeFromSuperview() }
        setup()
    }
    
    private func setup() {
        nibViewError = nonThrowingSetup(nibViewKeyPath: \.nibView)
    }
    
    open func nibDidLoad() { }
}

// MARK: - UICollectionView Reusable Views

// MARK: NibCollectionViewCell

/**
 Collection View Cell built as the superview of a `UIView` in a nib.
 
 ## Usage:
 ### Code side
 1. Inherit this generic *class* with a `ViewLoadableFromNib` as parameter type.
 
 Note: The nib loading is already defined by the `ViewLoadableFromNib` type.
 ### Available initializers
 - `init(frame:)`
 - `init?(coder: NSCoder)`
 
 Note: When an error occurs during initialization, it is reported in property `nibViewError`.
 ## Lifecycle
 The `nibDidLoad()` function is called after the view has loaded its nib.
 You usually override this function to perform additional initialization on subviews.
 */
open class NibCollectionViewCell<V>: UICollectionViewCell, SuperviewLoadableFromNib where V: UIView & ViewLoadableFromNib {
    
    public private(set) var nibView: V?
    public private(set) var nibViewError: Error?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView.subviews.forEach { $0.removeFromSuperview() }
        setup()
    }
    
    private func setup() {
        nibViewError = nonThrowingSetup(nibViewKeyPath: \.nibView, addNibViewIn: contentView)
    }
    
    open func nibDidLoad() { }
}

// MARK: NibCollectionReusableView

/**
 Collection Reusable View built as the superview of a `UIView` in a nib.
 
 ## Usage:
 ### Code side
 1. Inherit this generic *class* with a `ViewLoadableFromNib` as parameter type.
 
 Note: The nib loading is already defined by the `ViewLoadableFromNib` type.
 ### Available initializers
 - `init(frame:)`
 - `init?(coder: NSCoder)`
 
 Note: When an error occurs during initialization, it is reported in property `nibViewError`.
 ## Lifecycle
 The `nibDidLoad()` function is called after the view has loaded its nib.
 You usually override this function to perform additional initialization on subviews.
 */
open class NibCollectionReusableView<V>: UICollectionReusableView, SuperviewLoadableFromNib where V: UIView & ViewLoadableFromNib {
    
    public private(set) var nibView: V?
    public private(set) var nibViewError: Error?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        subviews.forEach { $0.removeFromSuperview() }
        setup()
    }
    
    private func setup() {
        nibViewError = nonThrowingSetup(nibViewKeyPath: \.nibView)
    }
    
    open func nibDidLoad() { }
}

// MARK: - Reusable Views Setup

private extension SuperviewLoadableFromNib where Self: UIView {
    
    func setup(nibViewKeyPath: ReferenceWritableKeyPath<Self, NibView?>,
               addNibViewIn superview: UIView? = nil) throws {
        let superview = superview ?? self
        let view = try NibView.fromNib(frame: superview.bounds)
        superview.addSubview(scaledToFill: view)
        self[keyPath: nibViewKeyPath] = view
        nibDidLoad()
    }
    
    func nonThrowingSetup(nibViewKeyPath: ReferenceWritableKeyPath<Self, NibView?>,
                          addNibViewIn superview: UIView? = nil) -> Error? {
        do {
            try setup(nibViewKeyPath: nibViewKeyPath, addNibViewIn: superview)
            return nil
        } catch {
            return error
        }
    }
}
