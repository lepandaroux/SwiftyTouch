//
//  UIView+LayoutTests.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import XCTest
@testable import SwiftyTouch

class UIViewLayoutTests: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        viewController = UIViewLayoutViewController()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    // https://blog.smartnsoft.com/layout-guide-margins-insets-and-safe-area-demystified-on-ios-10-11-d6e7246d7cb8
    
    @available(iOS 11.0, *)
    func testSafeArea() {
//        // Given
//        viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 64, left: 16, bottom: 49, right: 32)
//        let subview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
//        // When
//        viewController.view.addSubview(scaledToFill: subview)
//        viewController.view.layoutIfNeeded()
//        // Then
//        let test1 = viewController.view.bounds
//        let test2 = subview.frame
//        let test3 = viewController.view.safeAreaInsets
//        let test4 = subview.safeAreaInsets
//        XCTAssertEqual(viewController.view.bounds, subview.frame, "Subview not resized properly")
    }
}
