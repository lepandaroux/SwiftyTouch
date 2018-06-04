//
//  NibIBNestableViewController.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

// MARK: - NibIBNestableViewController

/**
 View Controller built as the *File's Owner* of a `UIView` in a nib.
 
 - Important: Usable as casted `UIViewController` inside **Interface Builder**!
 ## Usage:
 ### Code side
 1. Inherit this *class* with a `final` one.
 2. Override function `nibFile()`.
 ### Nib side
 1. Create a `UIView` in your nib file.
 2. Set the *File's Owner* of your nib file to your class.
 ### Available initializers
 - `fromNib()`
 - `init(fromNib:)`
 - `init()`
 - `init?(coder: NSCoder)`
 
 Note: When an error occurs in a non throwing initializer, it is reported in property `nibViewError`.
 */
open class NibIBNestableViewController: UIViewController, ViewControllerLoadableFromNib {
    
    open class func nibFile() throws -> NibFileConvertible {
        throw NibError.functionNibFileNotOverridden(for: self, baseClass: NibIBNestableViewController.self)
    }
    
    
    
    public static func fromNib() throws -> Self {
        return try self.init(fromNib: nil)
    }
    
    public private(set) var nibViewError: Error?
    
    // MARK: Initialization
    
    public required init(fromNib: Void?) throws {
        let nibFile = try type(of: self).nibFile()
        try nibFile.checkPath(for: type(of: self))
        super.init(nibName: nibFile.nibName, bundle: nibFile.nibBundle)
    }
    
    public init() {
        do {
            let nibFile = try type(of: self).nibFile()
            try nibFile.checkPath(for: type(of: self))
            super.init(nibName: nibFile.nibName, bundle: nibFile.nibBundle)
        } catch {
            super.init(nibName: nil, bundle: nil)
            nibViewError = error
        }
    }
    
    /*
     This is the designated initializer for this class. When using a storyboard to define your view controller and its associated views, you never initialize your view controller class directly. Instead, view controllers are instantiated by the storyboard either automatically when a segue is triggered or programmatically when your app calls the instantiateViewController(withIdentifier:) method of a storyboard object. When instantiating a view controller from a storyboard, iOS initializes the new view controller by calling its init(coder:) method instead of this method and sets the nibName property to a nib file stored inside the storyboard.
     
     The nib file you specify is not loaded right away. It is loaded the first time the view controller's view is accessed. If you want to perform additional initialization after the nib file is loaded, override the viewDidLoad() method and perform your tasks there.
     
     If you specify nil for the nibName parameter and you do not override the loadView() method, the view controller searches for a nib file as described in the nibName property.
     */
    @available(*, unavailable, renamed: "init()")
    public convenience override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        view = nil
        do {
            let nibFile = try type(of: self).nibFile()
            try nibFile.checkPath(for: type(of: self))
        } catch {
            nibViewError = error
        }
    }
    
    // MARK: Loading
    
    /*
     You should never call this method directly. The view controller calls this method when its view property is requested but is currently nil. This method loads or creates a view and assigns it to the view property.
     
     If the view controller has an associated nib file, this method loads the view from the nib file. A view controller has an associated nib file if the nibName property returns a non-nil value, which occurs if the view controller was instantiated from a storyboard, if you explicitly assigned it a nib file using the init(nibName:bundle:) method, or if iOS finds a nib file in the app bundle with a name based on the view controller's class name. If the view controller does not have an associated nib file, this method creates a plain UIView object instead.
     
     If you use Interface Builder to create your views and initialize the view controller, you must not override this method.
     
     You can override this method in order to create your views manually. If you choose to do so, assign the root view of your view hierarchy to the view property. The views you create should be unique instances and should not be shared with any other view controller object. Your custom implementation of this method should not call super.
     
     If you want to perform any additional initialization of your views, do so in the viewDidLoad() method.
     */
    open override func loadView() {
        do {
            view = try nibView()
        } catch {
            nibViewError = error
            view = nil
        }
    }
}

private extension NibIBNestableViewController {
    
    func nibView() throws -> UIView {
        guard type(of: self) != NibIBNestableViewController.self else {
            throw NibError.classNotInherited(NibIBNestableViewController.self)
        }
        let view = try NibObjectProvider.instantiateNibView(withOwnerViewController: self,
                                                            from: type(of: self).nibFile(),
                                                            nibObjectIndex: nil)
        return view
    }
}
