//
//  UICollectionViewFlowLayout.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 21/06/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

// MARK: - Layout configuration
// Try to call each once only per final computation to limit calls to delegate.

public extension UICollectionViewFlowLayout {
    
    public func itemSize(at indexPath: IndexPath) -> CGSize {
        if let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let size = delegate.collectionView?(collectionView,
                                                layout: self,
                                                sizeForItemAt: indexPath) {
            return size
        } else {
            return itemSize
        }
    }
    
    public func sectionInsetForSection(at index: Int) -> UIEdgeInsets {
        if let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let inset = delegate.collectionView?(collectionView,
                                                 layout: self,
                                                 insetForSectionAt: index) {
            return inset
        } else {
            return sectionInset
        }
    }
    
    public func minimumLineSpacingForSection(at index: Int) -> CGFloat {
        if let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let spacing = delegate.collectionView?(collectionView,
                                                   layout: self,
                                                   minimumLineSpacingForSectionAt: index) {
            return spacing
        } else {
            return minimumLineSpacing
        }
    }
    
    public func minimumInteritemSpacingForSection(at index: Int) -> CGFloat {
        if let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let spacing = delegate.collectionView?(collectionView,
                                                   layout: self,
                                                   minimumInteritemSpacingForSectionAt: index) {
            return spacing
        } else {
            return minimumInteritemSpacing
        }
    }
    
    public func headerReferenceSizeForSection(at index: Int) -> CGSize {
        if let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let size = delegate.collectionView?(collectionView,
                                                layout: self,
                                                referenceSizeForHeaderInSection: index) {
            return size
        } else {
            return headerReferenceSize
        }
    }
    
    public func footerReferenceSizeForSection(at index: Int) -> CGSize {
        if let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let size = delegate.collectionView?(collectionView,
                                                layout: self,
                                                referenceSizeForFooterInSection: index) {
            return size
        } else {
            return footerReferenceSize
        }
    }
}

// MARK: - Item size computation

public extension UICollectionViewFlowLayout {
    
    /// Compute the fixed dimension for an item on a line according to parameters.
    /// - parameter index: The index of the section
    /// - parameter numberOfColumns: The number of columns in the section
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The fixed dimension computed
    public func itemFixedDimension(inSectionAt index: Int,
                                   numberOfColumns: UInt = 1,
                                   withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGFloat {
        let sectionInset = sectionInsetForSection(at: index)
        return itemFixedDimension(inSectionAt: index,
                                  sectionInset: sectionInset,
                                  numberOfColumns: numberOfColumns,
                                  withCollectionViewExpectedBoundsSize: expectedBoundsSize)
    }
    
    private func itemFixedDimension(inSectionAt index: Int,
                                    sectionInset: UIEdgeInsets,
                                    numberOfColumns: UInt,
                                    withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        let lineAvailableSpace: CGFloat
        switch scrollDirection {
        case .vertical:
            lineAvailableSpace = availableWidthInSection(sectionInset: sectionInset,
                                                         withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        case .horizontal:
            lineAvailableSpace = availableHeightInSection(sectionInset: sectionInset,
                                                          withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        }
        guard numberOfColumns > 1 else {
            return lineAvailableSpace
        }
        let minimumInteritemSpacing = minimumInteritemSpacingForSection(at: index)
        return availableSpaceInLine(forNumberOfColumns: numberOfColumns,
                                    lineAvailableSpace: lineAvailableSpace,
                                    minimumInteritemSpacing: minimumInteritemSpacing)
    }
    
    /// Compute the visible scrollable dimension for an item on a column according to parameters.
    /// - parameter index: The index of the section
    /// - parameter numberOfLines: The number of visible lines
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The visible scrollable dimension computed
    public func itemVisibleScrollableDimension(inSectionAt index: Int,
                                               numberOfLines: UInt = 1,
                                               withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGFloat {
        let sectionInset = sectionInsetForSection(at: index)
        return itemVisibleScrollableDimension(inSectionAt: index,
                                              sectionInset: sectionInset,
                                              numberOfLines: numberOfLines,
                                              withCollectionViewExpectedBoundsSize: expectedBoundsSize)
    }
    
    private func itemVisibleScrollableDimension(inSectionAt index: Int,
                                                sectionInset: UIEdgeInsets,
                                                numberOfLines: UInt,
                                                withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        let columnVisibleSpace: CGFloat
        switch scrollDirection {
        case .vertical:
            columnVisibleSpace = availableHeightInSection(sectionInset: sectionInset,
                                                          withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        case .horizontal:
            columnVisibleSpace = availableWidthInSection(sectionInset: sectionInset,
                                                         withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        }
        guard numberOfLines > 1 else {
            return columnVisibleSpace
        }
        let minimumLineSpacing = minimumLineSpacingForSection(at: index)
        return availableSpaceInColumn(forNumberOfLines: numberOfLines,
                                      columnAvailableSpace: columnVisibleSpace,
                                      minimumLineSpacing: minimumLineSpacing)
    }
    
    /// Compute the visible size for an item inside a section according to parameters.
    /// - parameter index: The index of the section
    /// - parameter numberOfLines: The number of visible lines
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The visible size computed
    public func itemVisibleSize(inSectionAt index: Int,
                                numberOfColumns: UInt = 1,
                                numberOfLines: UInt = 1,
                                withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGSize {
        let sectionInset = sectionInsetForSection(at: index)
        let fixedDimension = itemFixedDimension(inSectionAt: index,
                                                sectionInset: sectionInset,
                                                numberOfColumns: numberOfColumns,
                                                withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        let visibleScrollableDimension = itemVisibleScrollableDimension(inSectionAt: index,
                                                                        sectionInset: sectionInset,
                                                                        numberOfLines: numberOfLines,
                                                                        withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        switch scrollDirection {
        case .vertical:
            return CGSize(width: fixedDimension, height: visibleScrollableDimension)
        case .horizontal:
            return CGSize(width: visibleScrollableDimension, height: fixedDimension)
        }
    }
}

// MARK: - Section size computation

public extension UICollectionViewFlowLayout {
    
    /// Compute the fixed dimension of a section according to parameters.
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The section fixed dimension computed
    public func sectionFixedDimension(withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGFloat {
        switch scrollDirection {
        case .vertical:
            return availableWidthInContent(withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        case .horizontal:
            return availableHeightInContent(withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        }
    }
    
    /// Compute the scrollable dimension of a section according to parameters.
    /// - parameter index: The index of the section
    /// - parameter numberOfItems: The number of items in the section
    /// - parameter numberOfColumns: The number of columns in the section
    /// - returns: The section scrollable dimension computed
    public func sectionScrollableDimension(at index: Int,
                                           forNumberOfItems numberOfItems: UInt,
                                           numberOfColumns: UInt = 1) -> CGFloat {
        let columns = max(numberOfColumns, 1)
        let sectionInset = sectionInsetForSection(at: index)
        let headerReferenceSize = headerReferenceSizeForSection(at: index)
        let itemSizesInLines = stride(from: 0, to: numberOfItems, by: Int(columns)).map {
            Array($0..<min($0 + columns, numberOfItems)).map {
                itemSize(at: IndexPath(row: Int($0), section: index))
            }
        }
        let minimumLineSpacing = minimumLineSpacingForSection(at: index)
        let footerReferenceSize = footerReferenceSizeForSection(at: index)
        switch scrollDirection {
        case .vertical:
            return scrollableHeightOfSection(forItemSizesInLines: itemSizesInLines,
                                             sectionInset: sectionInset,
                                             headerReferenceSize: headerReferenceSize,
                                             minimumLineSpacing: minimumLineSpacing,
                                             footerReferenceSize: footerReferenceSize)
        case .horizontal:
            return scrollableWidthOfSection(forItemSizesInLines: itemSizesInLines,
                                            sectionInset: sectionInset,
                                            headerReferenceSize: headerReferenceSize,
                                            minimumLineSpacing: minimumLineSpacing,
                                            footerReferenceSize: footerReferenceSize)
        }
    }
    
    /// Compute the size of a section according to parameters.
    /// - parameter index: The index of the section
    /// - parameter numberOfItems: The number of items in the section
    /// - parameter numberOfColumns: The number of columns in the section
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The section size computed
    public func sectionSize(at index: Int,
                            forNumberOfItems numberOfItems: UInt,
                            numberOfColumns: UInt = 1,
                            withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGSize {
        let fixedDimension = sectionFixedDimension(withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        let scrollableDimension = sectionScrollableDimension(at: index,
                                                             forNumberOfItems: numberOfItems,
                                                             numberOfColumns: numberOfColumns)
        switch scrollDirection {
        case .vertical:
            return CGSize(width: fixedDimension, height: scrollableDimension)
        case .horizontal:
            return CGSize(width: scrollableDimension, height: fixedDimension)
        }
    }
}

// MARK: - Content size computation

public extension UICollectionViewFlowLayout {
    
    /// Compute the fixed dimension of the content of the collection view according to parameters.
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The content fixed dimension computed
    public func contentFixedDimension(withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGFloat {
        switch scrollDirection {
        case .vertical:
            return availableWidthInCollectionView(withExpectedBoundsSize: expectedBoundsSize)
        case .horizontal:
            return availableHeightInCollectionView(withExpectedBoundsSize: expectedBoundsSize)
        }
    }
    
    /// Compute the scrollable dimension of the content of the collection view according to parameters.
    /// - parameter numberOfItemsInSections: The number of items for each section
    /// - parameter numberOfColumns: The same number of columns for each section
    /// - returns: The content scrollable dimension computed
    public func contentScrollableDimension(forNumberOfItemsInSections numberOfItemsInSections: [UInt],
                                           numberOfColumns: UInt = 1) -> CGFloat {
        return contentScrollableDimension(forSections: numberOfItemsInSections.map { ($0, numberOfColumns) })
    }
    
    /// Compute the scrollable dimension of the content of the collection view according to parameters.
    /// - parameter sections: A tuple composed of the number of items and the number of columns for each section
    /// - returns: The content scrollable dimension computed
    public func contentScrollableDimension(forSections sections: [(numberOfItems: UInt, numberOfColumns: UInt)]) -> CGFloat {
        let sectionsScrollableDimensions = sections.enumerated().map {
            return sectionScrollableDimension(at: $0.offset,
                                              forNumberOfItems: $0.element.numberOfItems,
                                              numberOfColumns: $0.element.numberOfColumns)
        }
        switch scrollDirection {
        case .vertical:
            return scrollableHeightOfContent(forSectionsScrollableHeights: sectionsScrollableDimensions)
        case .horizontal:
            return scrollableWidthOfContent(forSectionsScrollableWidths: sectionsScrollableDimensions)
        }
    }
    
    /// Compute the size of the content of the collection view according to parameters.
    /// - parameter numberOfItemsInSections: The number of items for each section
    /// - parameter numberOfColumns: The same number of columns for each section
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The content size computed
    public func contentSize(forNumberOfItemsInSections numberOfItemsInSections: [UInt],
                            numberOfColumns: UInt = 1,
                            withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGSize {
        return contentSize(forSections: numberOfItemsInSections.map { ($0, numberOfColumns) },
                           withCollectionViewExpectedBoundsSize: expectedBoundsSize)
    }
    
    /// Compute the size of the content of the collection view according to parameters.
    /// - parameter sections: A tuple composed of the number of items and the number of columns for each section
    /// - parameter expectedBoundsSize: Provide the expected bounds’ size of the collection view in case this last is not layout yet.
    /// - returns: The content size computed
    public func contentSize(forSections sections: [(numberOfItems: UInt, numberOfColumns: UInt)],
                            withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize? = nil) -> CGSize {
        let fixedDimension = contentFixedDimension(withCollectionViewExpectedBoundsSize: expectedBoundsSize)
        let scrollableDimension = contentScrollableDimension(forSections: sections)
        switch scrollDirection {
        case .vertical:
            return CGSize(width: fixedDimension, height: scrollableDimension)
        case .horizontal:
            return CGSize(width: scrollableDimension, height: fixedDimension)
        }
    }
}

// MARK: - Computation
// Ask configuration variables as parameters to allow them being called once per final computation.

private extension UICollectionViewFlowLayout {
    
    var unadjustedContentInset: UIEdgeInsets {
        guard let collectionView = collectionView else {
            return .zero
        }
        var contentInset = collectionView.contentInset
        if #available(iOS 11.0, *) {
            // Variations of contentInset are managed in `adjustedContentInset`
            return contentInset
        } else if #available(iOS 10.0, *) {
            if let refreshControl = collectionView.refreshControl, refreshControl.isRefreshing {
                switch scrollDirection {
                case .vertical:
                    contentInset.top -= refreshControl.frame.height
                case .horizontal:
                    contentInset.left -= refreshControl.frame.width
                }
            }
            return contentInset
        } else {
            return contentInset
        }
    }
    
    // MARK: Top-Down computations
    
    func availableWidthInCollectionView(withExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return expectedBoundsSize?.width ?? collectionView.bounds.width
    }
    
    func availableHeightInCollectionView(withExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return expectedBoundsSize?.height ?? collectionView.bounds.height
    }
    
    func availableWidthInContent(withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        let contentInset = self.unadjustedContentInset
        let availableWidth = availableWidthInCollectionView(withExpectedBoundsSize: expectedBoundsSize)
            - contentInset.left - contentInset.right
        return max(availableWidth, 0)
    }
    
    func availableHeightInContent(withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        let contentInset = self.unadjustedContentInset
        let availableHeight = availableHeightInCollectionView(withExpectedBoundsSize: expectedBoundsSize)
            - contentInset.top - contentInset.bottom
        return max(availableHeight, 0)
    }
    
    func availableWidthInSection(sectionInset: UIEdgeInsets,
                                 withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        let availableWidth = availableWidthInContent(withCollectionViewExpectedBoundsSize: expectedBoundsSize)
            - sectionInset.left - sectionInset.right
        return max(availableWidth, 0)
    }
    
    func availableHeightInSection(sectionInset: UIEdgeInsets,
                                  withCollectionViewExpectedBoundsSize expectedBoundsSize: CGSize?) -> CGFloat {
        let availableHeight = availableHeightInContent(withCollectionViewExpectedBoundsSize: expectedBoundsSize)
            - sectionInset.top - sectionInset.bottom
        return max(availableHeight, 0)
    }
    
    func availableSpaceInLine(forNumberOfColumns numberOfColumns: UInt,
                              lineAvailableSpace: CGFloat,
                              minimumInteritemSpacing: CGFloat) -> CGFloat {
        let columns = CGFloat(max(numberOfColumns, 1))
        let itemsAvailableSpace = lineAvailableSpace - (columns - 1) * minimumInteritemSpacing
        let availableSpace = itemsAvailableSpace / columns
        return max(availableSpace, 0)
    }
    
    func availableSpaceInColumn(forNumberOfLines numberOfLines: UInt,
                                columnAvailableSpace: CGFloat,
                                minimumLineSpacing: CGFloat) -> CGFloat {
        let lines = CGFloat(max(numberOfLines, 1))
        let itemsAvailableSpace = columnAvailableSpace - (lines - 1) * minimumLineSpacing
        let availableSpace = itemsAvailableSpace / lines
        return max(availableSpace, 0)
    }
    
    // MARK: Bottom-Up computations
    
    func scrollableWidthOfSection(forItemSizesInLines itemSizesInLines: [[CGSize]],
                                  sectionInset: UIEdgeInsets,
                                  headerReferenceSize: CGSize,
                                  minimumLineSpacing: CGFloat,
                                  footerReferenceSize: CGSize) -> CGFloat {
        let linesWidths = itemSizesInLines.map { $0.reduce(CGFloat(0)) { max($0, $1.width) } }
        let itemsWidth = linesWidths.reduce(0, +) + CGFloat(linesWidths.count - 1) * minimumLineSpacing
        return headerReferenceSize.width + itemsWidth + footerReferenceSize.width
            + sectionInset.left + sectionInset.right
    }
    
    func scrollableHeightOfSection(forItemSizesInLines itemSizesInLines: [[CGSize]],
                                   sectionInset: UIEdgeInsets,
                                   headerReferenceSize: CGSize,
                                   minimumLineSpacing: CGFloat,
                                   footerReferenceSize: CGSize) -> CGFloat {
        let linesHeights = itemSizesInLines.map { $0.reduce(CGFloat(0)) { max($0, $1.height) } }
        let itemsHeight = linesHeights.reduce(0, +) + CGFloat(linesHeights.count - 1) * minimumLineSpacing
        return headerReferenceSize.height + itemsHeight + footerReferenceSize.height
            + sectionInset.top + sectionInset.bottom
    }
    
    func scrollableWidthOfContent(forSectionsScrollableWidths sectionsScrollableWidths: [CGFloat]) -> CGFloat {
        let contentInset = self.unadjustedContentInset
        return sectionsScrollableWidths.reduce(CGFloat(0), +) + contentInset.left + contentInset.right
    }
    
    func scrollableHeightOfContent(forSectionsScrollableHeights sectionsScrollableHeights: [CGFloat]) -> CGFloat {
        let contentInset = self.unadjustedContentInset
        return sectionsScrollableHeights.reduce(CGFloat(0), +) + contentInset.top + contentInset.bottom
    }
}
