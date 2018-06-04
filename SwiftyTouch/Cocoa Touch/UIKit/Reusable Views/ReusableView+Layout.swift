//
//  ReusableView+Layout.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 31/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

public protocol ReusableViewComputationCompatible { }

// MARK: - UITableView

// TODO: Support UITableViewCell

// MARK: - UICollectionView

extension UICollectionViewCell: ReusableViewComputationCompatible { }

private extension UICollectionViewCell {
    
    static var computationCells = [ObjectIdentifier : UICollectionViewCell]()
}

private extension ReusableViewComputationCompatible where Self: UICollectionViewCell {
    
    private static func computationCell() -> Self {
        guard let cell = computationCells[ObjectIdentifier(self)] else {
            let cell = self.init()
            computationCells[ObjectIdentifier(self)] = cell
            return cell
        }
        return cell as! Self
    }
    
    static func clearCell() {
        computationCells[ObjectIdentifier(self)] = nil
    }
    
    static func preparedCell(withConfiguration configuration: (Self) -> Void) -> Self {
        let cell = computationCell()
        configuration(cell)
        cell.setNeedsLayout()
        // `layoutIfNeeded` may raise constraints violation logs at this point if cell is not large enough for its content but it won't impact `systemLayoutSizeFitting` according to priorities passed to it as parameters.
        cell.layoutIfNeeded()
        return cell
    }
}

public extension ReusableViewComputationCompatible where Self: UICollectionViewCell {
    
    static func clearComputationData() {
        clearCell()
    }
    
    static func size(forWidth width: CGFloat,
                     withConfiguration configuration: (Self) -> Void) -> CGSize {
        let size = preparedCell(withConfiguration: configuration).contentView
            .systemLayoutSizeFitting(CGSize(width: width,
                                            height: UILayoutFittingCompressedSize.height),
                                     withHorizontalFittingPriority: UILayoutPriority.required,
                                     verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
        return CGSize(width: floor(size.width), height: floor(size.height))
    }
    
    static func size(forHeight height: CGFloat,
                     withConfiguration configuration: (Self) -> Void) -> CGSize {
        let size = preparedCell(withConfiguration: configuration).contentView
            .systemLayoutSizeFitting(CGSize(width: UILayoutFittingCompressedSize.width,
                                            height: height),
                                     withHorizontalFittingPriority: UILayoutPriority.fittingSizeLevel,
                                     verticalFittingPriority: UILayoutPriority.required)
        return CGSize(width: floor(size.width), height: floor(size.height))
    }
}
