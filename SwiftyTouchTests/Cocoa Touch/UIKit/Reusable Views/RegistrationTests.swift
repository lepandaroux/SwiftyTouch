//
//  RegistrationTests.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 31/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import XCTest
@testable import SwiftyTouch

private let swiftyTouchTestsBundle = Bundle(for: TableViewRegistrationTests.self)
private let registrationTableViewCellNibName                = "RegistrationTableViewCell"
private let registrationTableViewHeaderFooterViewNibName    = "RegistrationTableViewHeaderFooterView"
private let registrationCollectionViewCellNibName           = "RegistrationCollectionViewCell"
private let registrationCollectionViewReusableViewNibName   = "RegistrationCollectionViewReusableView"

class TableViewRegistrationTests: XCTestCase {
    
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 500))
        tableView = UITableView(frame: frame)
    }
    
    override func tearDown() {
        tableView = nil
        super.tearDown()
    }
    
    func testRegisterCellClassWithoutIndexPath() {
        // Given
        tableView.registerCell(TableViewCellClass.self)
        // When
        let cell = tableView.dequeueReusableCell(TableViewCellClass.self)
        // Then
        XCTAssertNotNil(cell, "Cell not dequeued")
    }
    
    func testRegisterCellClass() {
        // Given
        tableView.registerCell(TableViewCellClass.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        _ = tableView.dequeueReusableCell(TableViewCellClass.self,
                                          for: indexPath)
        // Then
        // No crash
    }
    
    func testRegisterHeaderFooterViewClass() {
        // Given
        tableView.registerHeaderFooterView(TableViewHeaderFooterViewClass.self)
        // When
        let view = tableView.dequeueReusableHeaderFooterView(TableViewHeaderFooterViewClass.self)
        // Then
        XCTAssertNotNil(view, "View not dequeued")
    }
    
    func testRegisterCellNibWithoutIndexPath() {
        // Given
        let nib = UINib(nibName: registrationTableViewCellNibName, bundle: swiftyTouchTestsBundle)
        tableView.registerNib(nib, forCellType: TableViewCellNib.self)
        // When
        let cell = tableView.dequeueReusableCell(TableViewCellNib.self)
        // Then
        XCTAssertNotNil(cell, "Cell not dequeued")
        XCTAssertNotNil(cell?.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testRegisterCellNib() {
        // Given
        let nib = UINib(nibName: registrationTableViewCellNibName, bundle: swiftyTouchTestsBundle)
        tableView.registerNib(nib, forCellType: TableViewCellNib.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        let cell = tableView.dequeueReusableCell(TableViewCellNib.self,
                                                 for: indexPath)
        // Then
        // No crash
        XCTAssertNotNil(cell.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testRegisterHeaderFooterViewNib() {
        // Given
        let nib = UINib(nibName: registrationTableViewHeaderFooterViewNibName, bundle: swiftyTouchTestsBundle)
        tableView.registerNib(nib, forHeaderFooterViewType: TableViewHeaderFooterViewNib.self)
        // When
        let view = tableView.dequeueReusableHeaderFooterView(TableViewHeaderFooterViewNib.self)
        // Then
        XCTAssertNotNil(view, "View not dequeued")
        XCTAssertNotNil(view?.outlet, "View not loaded properly: outlet not linked")
    }
}

class CollectionViewRegistrationTests: XCTestCase {
    
    private final class DataSource: NSObject, UICollectionViewDataSource {
        
        public func collectionView(_ collectionView: UICollectionView,
                                   numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        public func collectionView(_ collectionView: UICollectionView,
                                   cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return UICollectionViewCell()
        }
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDataSource!
    
    override func setUp() {
        super.setUp()
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 500))
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 300, height: 100)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        dataSource = DataSource()
        // Provide numberOfItemsInSection from dataSource to avoid a crash when dequeuing a cell on non-existent IndexPath
        collectionView.dataSource = dataSource
        // Force computation of numberOfSections to avoid a crash when dequeuing a supplementary view
        _ = collectionView.numberOfSections
    }
    
    override func tearDown() {
        collectionView = nil
        dataSource = nil
        super.tearDown()
    }
    
    func testRegisterCellClass() {
        // Given
        collectionView.registerCell(CollectionViewCellClass.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // Whens
        _ = collectionView.dequeueReusableCell(CollectionViewCellClass.self, for: indexPath)
        // Then
        // No crash
    }
    
    func testRegisterSupplementaryViewClass() {
        // Given
        let viewKind = UICollectionView.elementKindSectionHeader
        collectionView.registerSupplementaryView(CollectionReusableViewClass.self, ofKind: viewKind)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        _ = collectionView.dequeueReusableSupplementaryView(CollectionReusableViewClass.self,
                                                            ofKind: viewKind,
                                                            for: indexPath)
        // Then
        // No crash
    }
    
    func testRegisterHeaderViewClass() {
        // Given
        collectionView.registerHeaderView(CollectionReusableViewClass.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        _ = collectionView.dequeueReusableHeaderView(CollectionReusableViewClass.self,
                                                     for: indexPath)
        // Then
        // No crash
    }
    
    func testRegisterFooterViewClass() {
        // Given
        collectionView.registerFooterView(CollectionReusableViewClass.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        _ = collectionView.dequeueReusableFooterView(CollectionReusableViewClass.self,
                                                     for: indexPath)
        // Then
        // No crash
    }
    
    func testRegisterCellNib() {
        // Given
        let nib = UINib(nibName: registrationCollectionViewCellNibName, bundle: swiftyTouchTestsBundle)
        collectionView.registerNib(nib,
                                   forCellType: CollectionViewCellNib.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // Whens
        let cell = collectionView.dequeueReusableCell(CollectionViewCellNib.self, for: indexPath)
        // Then
        // No crash
        XCTAssertNotNil(cell.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testRegisterSupplementaryViewNib() {
        // Given
        let viewKind = UICollectionView.elementKindSectionHeader
        let nib = UINib(nibName: registrationCollectionViewReusableViewNibName, bundle: swiftyTouchTestsBundle)
        collectionView.registerNib(nib, forSupplementaryViewType: CollectionReusableViewNib.self,
                                   ofKind: viewKind)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        let view = collectionView.dequeueReusableSupplementaryView(CollectionReusableViewNib.self,
                                                                   ofKind: viewKind,
                                                                   for: indexPath)
        // Then
        // No crash
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testRegisterHeaderViewNib() {
        // Given
        let nib = UINib(nibName: registrationCollectionViewReusableViewNibName, bundle: swiftyTouchTestsBundle)
        collectionView.registerNib(nib, forHeaderViewType: CollectionReusableViewNib.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        let view = collectionView.dequeueReusableHeaderView(CollectionReusableViewNib.self,
                                                            for: indexPath)
        // Then
        // No crash
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
    }
    
    func testRegisterFooterViewNib() {
        // Given
        let nib = UINib(nibName: registrationCollectionViewReusableViewNibName, bundle: swiftyTouchTestsBundle)
        collectionView.registerNib(nib, forFooterViewType: CollectionReusableViewNib.self)
        let indexPath = IndexPath(row: 0, section: 0)
        // When
        let view = collectionView.dequeueReusableFooterView(CollectionReusableViewNib.self,
                                                            for: indexPath)
        // Then
        // No crash
        XCTAssertNotNil(view.outlet, "View not loaded properly: outlet not linked")
    }
}
