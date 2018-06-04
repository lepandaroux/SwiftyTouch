//
//  StoryboardConvertibleTests.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 04/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import XCTest
@testable import SwiftyTouch

class StoryboardConvertibleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialViewController() {
        // Given
        let vc: InitialViewController
        // When
        do {
            vc = try InitialViewController.fromStoryboard()
        } catch {
            XCTFail("\(error)")
            return
        }
        _ = vc.view // Load the view
        // Then
        XCTAssertNotNil(vc, "View Controller not instantiated")
        XCTAssertNotNil(vc.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testViewControllerWithStoryboardID() {
        // Given
        let vc: IdentifiedViewController
        // When
        do {
            vc = try IdentifiedViewController.fromStoryboard()
        } catch {
            XCTFail("\(error)")
            return
        }
        _ = vc.view // Load the view
        // Then
        XCTAssertNotNil(vc, "View Controller not instantiated")
        XCTAssertNotNil(vc.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testViewControllerWithInvalidStoryboard() {
        // Given
        // When
        do {
            _ = try InvalidStoryboardViewController.fromStoryboard()
        }
            // Then
        catch let e as StoryboardError {
            guard case .storyboardFileNotFound = e else {
                XCTFail("Unexpected error instead of 'storyboardFileNotFound':\n\(e)")
                return
            }
            debugPrint(e)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testViewControllerWithMissingInitial() {
        // Given
        // When
        do {
            _ = try MissingInitialViewController.fromStoryboard()
        }
            // Then
        catch let e as StoryboardError {
            guard case .viewControllerAsInitialNotFound = e else {
                XCTFail("Unexpected error instead of 'initialViewControllerNotFound':\n\(e)")
                return
            }
            debugPrint(e)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testViewControllerWithMissingStoryboardID() {
        // Given
        // When
        do {
            _ = try MissingIdentifierViewController.fromStoryboard()
        }
            // Then
        catch let e as StoryboardError {
            guard case .initialViewControllerOfTypeNotFound = e else {
                XCTFail("Unexpected error instead of 'initialViewControllerOfTypeNotFound':\n\(e)")
                return
            }
            debugPrint(e)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testViewControllerWithWrongExistingStoryboardID() {
        // Given
        // When
        do {
            _ = try WrongIdentifierViewController.fromStoryboard()
        }
            // Then
        catch let e as StoryboardError {
            guard case .identifiedViewControllerOfTypeNotFound = e else {
                XCTFail("Unexpected error instead of 'identifiedViewControllerOfTypeNotFound':\n\(e)")
                return
            }
            debugPrint(e)
        } catch {
            XCTFail("\(error)")
        }
    }
}
