//
//  NibConvertibleTests.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import XCTest
@testable import SwiftyTouch

class NibConvertibleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - NibCustomView
    
    func testFirstValidViewWithoutIndexFromNib() {
        // Given
        let view: FirstValidCustomView
        // When
        do {
            view = try FirstValidCustomView.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // Then
        XCTAssert(view.isNibDidLoadCalled == true, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
        XCTAssertEqual(view.indexLabel.text, "Index0", "View is not the expected one")
    }
    
    func testValidViewWithIndexFromNib() {
        // Given
        let view: IndexedValidCustomView
        // When
        do {
            view = try IndexedValidCustomView.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // Then
        XCTAssert(view.isNibDidLoadCalled == true, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
        XCTAssertEqual(view.indexLabel.text, "Index1", "View is not the expected one")
    }
    
    func testOtherValidViewWithoutIndexFromNib() {
        // Given
        let view: NotIndexedValidCustomView
        // When
        do {
            view = try NotIndexedValidCustomView.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // Then
        XCTAssert(view.isNibDidLoadCalled == true, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
        XCTAssertEqual(view.indexLabel.text, "Index2", "View is not the expected one")
    }
    
    // MARK: - NibOwnerView
    
    func testValidOwnerViewFromNib() {
        // Given
        let view: ValidOwnerView
        // When
        do {
            view = try ValidOwnerView.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // Then
        XCTAssert(view.isNibDidLoadCalled == true, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
    }
    
    // MARK: - NibIBNestableView
    
    func testValidIBNestableViewFromNib() {
        // Given
        let view: ValidIBNestableView
        // When
        do {
            view = try ValidIBNestableView.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // Then
        XCTAssert(view.isNibDidLoadCalled == true, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testValidIBNestableViewDefaultInit() {
        // Given
        // When
        let view = ValidIBNestableView()
        // Then
        XCTAssert(view.isNibDidLoadCalled == true, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testValidIBNestableViewEmbeddedInStoryboard() {
        // Given
        let storyboard = UIStoryboard(name: "NibConvertibleViewsStoryboard",
                                      bundle: Bundle(for: ValidIBNestableView.self))
        let vc = storyboard.instantiateInitialViewController()
        let vcView = vc?.view
        let vcSubviews = vcView?.subviews
        // When
        let view = vcSubviews?.first(where: { $0 is ValidIBNestableView })  as? ValidIBNestableView
        // Then
        XCTAssertNotNil(view, "View not instanciated")
        XCTAssert(view?.isNibDidLoadCalled == true, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view?.outlet, "View not loaded properly: outlet not linked")
    }
    
    // MARK: - NibCustomViewController
    
    func testValidCustomViewControllerFromNib() {
        // Given
        let vc: ValidCustomViewController
        // When
        do {
            vc = try ValidCustomViewController.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // No need to load view (decoded along with the view controller)
        // Then
        XCTAssertNotNil(vc.viewIfLoaded, "View not instantiated")
        XCTAssertNotNil(vc.outlet, "View not loaded properly: outlet not linked")
    }
    
    // MARK: - NibOwnerViewController
    
    func testValidOwnerViewControllerFromNib() {
        // Given
        let vc: ValidOwnerViewController
        // When
        do {
            vc = try ValidOwnerViewController.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // Then
        XCTAssertNil(vc.viewIfLoaded, "View loaded too early")
        _ = vc.view // Load the view
        XCTAssertNotNil(vc.viewIfLoaded, "View not instantiated")
        XCTAssertNotNil(vc.outlet, "View not loaded properly: outlet not linked")
    }
    
    // MARK: - NibIBNestableViewController
    
    func testValidIBNestableViewControllerFromNib() {
        // Given
        let vc: ValidIBNestableViewController
        // When
        do {
            vc = try ValidIBNestableViewController.fromNib()
        } catch {
            XCTFail("\(error)")
            return
        }
        // Then
        XCTAssertNil(vc.viewIfLoaded, "View loaded too early")
        _ = vc.view // Load the view
        XCTAssertNotNil(vc.viewIfLoaded, "View not instantiated")
        XCTAssertNotNil(vc.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testValidIBNestableViewControllerDefaultInit() {
        // Given
        // When
        let vc = ValidIBNestableViewController()
        // Then
        XCTAssertNil(vc.nibViewError, "Nib error raised: \(vc.nibViewError!)")
        XCTAssertNil(vc.viewIfLoaded, "View loaded too early")
        _ = vc.view // Load the view
        XCTAssertNotNil(vc.viewIfLoaded, "View not instantiated")
        XCTAssertNotNil(vc.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testValidIBNestableViewControllerEmbeddedInStoryboard() {
        // Given
        let storyboard = UIStoryboard(name: "NibConvertibleViewControllersStoryboard",
                                      bundle: Bundle(for: ValidIBNestableViewController.self))
        // When
        let vc = storyboard.instantiateInitialViewController() as? ValidIBNestableViewController
        // Then
        XCTAssertNotNil(vc, "View Controller not instantiated")
        XCTAssertNil(vc?.viewIfLoaded, "View loaded too early")
        _ = vc?.view // Load the view
        XCTAssertNotNil(vc?.viewIfLoaded, "View not instantiated")
        XCTAssertNotNil(vc?.outlet, "View not loaded properly: outlet not linked")
    }
    
    // MARK: - Nib Reusable Views
    
    func testValidTableViewCellFrameInit() {
        // Given
        let frame = CGRect(origin: .zero, size: CGSize(width: 320, height: 40))
        // When
        let cell = ValidTableViewCell(frame: frame)
        // Then
        XCTAssert(cell.isNibDidLoadCalled, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(cell.nibView, "Nib view not loaded properly")
    }
    
    func testValidTableViewHeaderFooterViewFrameInit() {
        // Given
        let frame = CGRect(origin: .zero, size: CGSize(width: 320, height: 40))
        // When
        let view = ValidTableViewHeaderFooterView(frame: frame)
        // Then
        XCTAssert(view.isNibDidLoadCalled, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.nibView, "Nib view not loaded properly")
    }
    
    func testValidCollectionViewCellFrameInit() {
        // Given
        let frame = CGRect(origin: .zero, size: CGSize(width: 320, height: 40))
        // When
        let cell = ValidCollectionViewCell(frame: frame)
        // Then
        XCTAssert(cell.isNibDidLoadCalled, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(cell.nibView, "Nib view not loaded properly")
    }
    
    func testValidCollectionReusableViewFrameInit() {
        // Given
        let frame = CGRect(origin: .zero, size: CGSize(width: 320, height: 40))
        // When
        let view = ValidCollectionReusableView(frame: frame)
        // Then
        XCTAssert(view.isNibDidLoadCalled, "Callback 'nibDidLoad()' not called")
        XCTAssertNotNil(view.nibView, "Nib view not loaded properly")
    }
}
