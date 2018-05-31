//
//  ReusableView+Registration.swift
//  SwiftyTouch
//
//  Created by Xavier Leporcher on 31/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

// MARK: - UITableView

public extension UITableViewCell {
    
    public static var defaultReuseIdentifier: String {
        return String(reflecting: self)
    }
}

public extension UITableViewHeaderFooterView {
    
    public static var defaultReuseIdentifier: String {
        return String(reflecting: self)
    }
}

public extension UITableView {
    
    func registerCell(_ cellType: UITableViewCell.Type) {
        register(cellType,
                 forCellReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    func registerNib(_ nib: UINib,
                     forCellType cellType: UITableViewCell.Type) {
        register(nib,
                 forCellReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    func registerHeaderFooterView(_ headerFooterViewType: UITableViewHeaderFooterView.Type) {
        register(headerFooterViewType,
                 forHeaderFooterViewReuseIdentifier: headerFooterViewType.defaultReuseIdentifier)
    }
    
    func registerNib(_ nib: UINib,
                     forHeaderFooterViewType headerFooterViewType: UITableViewHeaderFooterView.Type) {
        register(nib,
                 forHeaderFooterViewReuseIdentifier: headerFooterViewType.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell>(_ cellType: Cell.Type,
                                   withCustomIdentifier identifier: String? = nil)
        -> Cell? where Cell: UITableViewCell {
            let identifier = identifier ?? cellType.defaultReuseIdentifier
            return dequeueReusableCell(withIdentifier: identifier) as? Cell
    }
    
    func dequeueReusableCell<Cell>(_ cellType: Cell.Type,
                                   withCustomIdentifier identifier: String? = nil,
                                   for indexPath: IndexPath)
        -> Cell where Cell: UITableViewCell {
            let identifier = identifier ?? cellType.defaultReuseIdentifier
            return dequeueReusableCell(withIdentifier: identifier,
                                       for: indexPath) as! Cell
    }
    
    func dequeueReusableHeaderFooterView<HeaderFooterView>(_ headerFooterViewType: HeaderFooterView.Type,
                                                           withCustomIdentifier identifier: String? = nil)
        -> HeaderFooterView? where HeaderFooterView: UITableViewHeaderFooterView {
            let identifier = identifier ?? headerFooterViewType.defaultReuseIdentifier
            return dequeueReusableHeaderFooterView(withIdentifier: identifier) as? HeaderFooterView
    }
}

// MARK: - UICollectionView

public extension UICollectionReusableView {
    
    public static var defaultReuseIdentifier: String {
        return String(reflecting: self)
    }
}

public extension UICollectionView {
    
    func registerCell(_ cellType: UICollectionViewCell.Type) {
        register(cellType,
                 forCellWithReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    func registerNib(_ nib: UINib,
                     forCellType cellType: UICollectionViewCell.Type) {
        register(nib,
                 forCellWithReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    func registerSupplementaryView(_ supplementaryViewType: UICollectionReusableView.Type,
                                   ofKind elementKind: String) {
        register(supplementaryViewType,
                 forSupplementaryViewOfKind: elementKind,
                 withReuseIdentifier: supplementaryViewType.defaultReuseIdentifier)
    }
    
    func registerHeaderView(_ headerViewType: UICollectionReusableView.Type) {
        registerSupplementaryView(headerViewType, ofKind: UICollectionElementKindSectionHeader)
    }
    
    func registerFooterView(_ footerViewType: UICollectionReusableView.Type) {
        registerSupplementaryView(footerViewType, ofKind: UICollectionElementKindSectionFooter)
    }
    
    func registerNib(_ nib: UINib,
                     forSupplementaryViewType supplementaryViewType: UICollectionReusableView.Type,
                     ofKind kind: String) {
        register(nib,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: supplementaryViewType.defaultReuseIdentifier)
    }
    
    func registerNib(_ nib: UINib,
                     forHeaderViewType headerViewType: UICollectionReusableView.Type) {
        registerNib(nib, forSupplementaryViewType: headerViewType, ofKind: UICollectionElementKindSectionHeader)
    }
    
    func registerNib(_ nib: UINib,
                     forFooterViewType footerViewType: UICollectionReusableView.Type) {
        registerNib(nib, forSupplementaryViewType: footerViewType, ofKind: UICollectionElementKindSectionFooter)
    }
    
    func dequeueReusableCell<Cell>(_ cellType: Cell.Type,
                                   withCustomReuseIdentifier identifier: String? = nil,
                                   for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        let identifier = identifier ?? cellType.defaultReuseIdentifier
        return dequeueReusableCell(withReuseIdentifier: identifier,
                                   for: indexPath) as! Cell
    }
    
    func dequeueReusableSupplementaryView<SupplementaryView>(_ supplementaryViewType: SupplementaryView.Type,
                                                             ofKind elementKind: String,
                                                             withCustomReuseIdentifier identifier: String? = nil,
                                                             for indexPath: IndexPath)
        -> SupplementaryView where SupplementaryView: UICollectionReusableView {
            let identifier = identifier ?? supplementaryViewType.defaultReuseIdentifier
            return dequeueReusableSupplementaryView(ofKind: elementKind,
                                                    withReuseIdentifier: identifier,
                                                    for: indexPath) as! SupplementaryView
    }
    
    func dequeueReusableHeaderView<HeaderView>(_ headerViewType: HeaderView.Type,
                                               withCustomReuseIdentifier identifier: String? = nil,
                                               for indexPath: IndexPath)
        -> HeaderView where HeaderView: UICollectionReusableView {
            return dequeueReusableSupplementaryView(headerViewType,
                                                    ofKind: UICollectionElementKindSectionHeader,
                                                    withCustomReuseIdentifier: identifier,
                                                    for: indexPath)
    }
    
    func dequeueReusableFooterView<FooterView>(_ footerViewType: FooterView.Type,
                                               withCustomReuseIdentifier identifier: String? = nil,
                                               for indexPath: IndexPath)
        -> FooterView where FooterView: UICollectionReusableView {
            return dequeueReusableSupplementaryView(footerViewType,
                                                    ofKind: UICollectionElementKindSectionFooter,
                                                    withCustomReuseIdentifier: identifier,
                                                    for: indexPath)
    }
}
