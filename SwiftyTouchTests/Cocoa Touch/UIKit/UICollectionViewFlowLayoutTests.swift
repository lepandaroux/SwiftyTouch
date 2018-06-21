//
//  UICollectionViewFlowLayoutTests.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 21/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import XCTest
@testable import SwiftyTouch

class UICollectionViewFlowLayoutTests: XCTestCase {
    
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    
    override func setUp() {
        super.setUp()
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 500)),
                                          collectionViewLayout: flowLayout)
    }
    
    override func tearDown() {
        flowLayout = nil
        collectionView = nil
        super.tearDown()
    }
    
    func testItemFixedDimension() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        let sectionIndex = 0
        let numberOfColumns = UInt(2)
        // When
        let value = flowLayout.itemFixedDimension(inSectionAt: sectionIndex,
                                                  numberOfColumns: numberOfColumns)
        // Then
        let columns = CGFloat(numberOfColumns)
        let result: CGFloat = (300 - 2 - 8 - 2 - 8 - 10 * (columns - 1)) / columns
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testItemVisibleScrollableDimension() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        let sectionIndex = 0
        let numberOfLines = UInt(2)
        // When
        let value = flowLayout.itemVisibleScrollableDimension(inSectionAt: sectionIndex,
                                                              numberOfLines: numberOfLines)
        // Then
        let lines = CGFloat(numberOfLines)
        let result: CGFloat = (500 - 1 - 4 - 1 - 4 - 20 * (lines - 1)) / lines
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testItemVisibleSize() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        let sectionIndex = 0
        let numberOfColumns = UInt(2)
        let numberOfLines = UInt(2)
        // When
        let value = flowLayout.itemVisibleSize(inSectionAt: sectionIndex,
                                               numberOfColumns: numberOfColumns,
                                               numberOfLines: numberOfLines)
        // Then
        let columns = CGFloat(numberOfColumns)
        let lines = CGFloat(numberOfLines)
        let result: CGSize = CGSize(width: (300 - 2 - 8 - 2 - 8 - 10 * (columns - 1)) / columns,
                                    height: (500 - 1 - 4 - 1 - 4 - 20 * (lines - 1)) / lines)
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testSectionFixedDimension() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        // When
        let value = flowLayout.sectionFixedDimension()
        // Then
        let result: CGFloat = 300 - 2 - 8
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testSectionScrollableDimension() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        let sectionIndex = 0
        let numberOfItems = UInt(7)
        let numberOfColumns = UInt(2)
        // When
        let value = flowLayout.sectionScrollableDimension(at: sectionIndex,
                                                          forNumberOfItems: numberOfItems,
                                                          numberOfColumns: numberOfColumns)
        // Then
        let lines = ceil(CGFloat(numberOfItems) / CGFloat(numberOfColumns))
        let result: CGFloat = 1 + 4 + 16 + 14 + 20 * (lines - 1) + 80 * lines
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testSectionSize() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        let sectionIndex = 0
        let numberOfItems = UInt(7)
        let numberOfColumns = UInt(2)
        // When
        let value = flowLayout.sectionSize(at: sectionIndex,
                                           forNumberOfItems: numberOfItems,
                                           numberOfColumns: numberOfColumns)
        // Then
        let lines = ceil(CGFloat(numberOfItems) / CGFloat(numberOfColumns))
        let result: CGSize = CGSize(width: 300 - 2 - 8,
                                    height: 1 + 4 + 16 + 14 + 20 * (lines - 1) + 80 * lines)
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testContentFixedDimension() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        // When
        let value = flowLayout.contentFixedDimension()
        // Then
        let result: CGFloat = 300
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testContentScrollableDimension() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        let sections: [(UInt, UInt)] = [(7, 2), (4, 3)]
        // When
        let value = flowLayout.contentScrollableDimension(forSections: sections)
        // Then
        let linesInSections = sections.map { ceil(CGFloat($0.0) / CGFloat($0.1)) }
        let result: CGFloat = 1 + 4
            + 1 + 4 + 16 + 14 + 20 * (linesInSections[0] - 1) + 80 * linesInSections[0]
            + 1 + 4 + 16 + 14 + 20 * (linesInSections[1] - 1) + 80 * linesInSections[1]
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
    
    func testContentSize() {
        // Given
        collectionView.frame.size = CGSize(width: 300, height: 500)
        collectionView.contentInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 16)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 14)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 100, height: 80)
        let sections: [(UInt, UInt)] = [(7, 2), (4, 3)]
        // When
        let value = flowLayout.contentSize(forSections: sections)
        // Then
        let linesInSections = sections.map { ceil(CGFloat($0.0) / CGFloat($0.1)) }
        let result: CGSize = CGSize(width: 300,
                                    height: 1 + 4
                                        + 1 + 4 + 16 + 14 + 20 * (linesInSections[0] - 1) + 80 * linesInSections[0]
                                        + 1 + 4 + 16 + 14 + 20 * (linesInSections[1] - 1) + 80 * linesInSections[1])
        XCTAssertEqual(value, result, "Value computed is wrong")
    }
}
