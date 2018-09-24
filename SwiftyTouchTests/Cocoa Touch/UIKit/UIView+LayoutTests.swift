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
    
    var viewController: UIViewLayoutViewController!
    
    override func setUp() {
        super.setUp()
        viewController = UIViewLayoutViewController.shared
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    @available(iOS 11.0, *)
    
    func testAddSubviewSafeArea() {
//        // Given
//        viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 64, left: 16, bottom: 49, right: 32)
//        let subview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
//        // When
//        viewController.view.addSubviewConstrained(subview, relativeTo: .safeArea)
//        viewController.view.layoutIfNeeded()
//        // Then
//        let test1 = viewController.view.bounds
//        let test2 = subview.frame
//        let test3 = viewController.view.safeAreaInsets
//        let test4 = subview.safeAreaInsets
//        XCTAssertEqual(viewController.view.bounds, subview.frame, "Subview not resized properly")
    }
}
