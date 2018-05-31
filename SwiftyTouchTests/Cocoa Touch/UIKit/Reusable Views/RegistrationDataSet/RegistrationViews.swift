//
//  ReusableViewRegistrationViews.swift
//  SwiftyTouchTests
//
//  Created by Xavier Leporcher on 31/05/2018.
//  Copyright © 2018 LEPandaRouX. All rights reserved.
//

import UIKit

class TableViewCellClass: UITableViewCell { }
class TableViewHeaderFooterViewClass: UITableViewHeaderFooterView { }
class CollectionViewCellClass: UICollectionViewCell { }
class CollectionReusableViewClass: UICollectionReusableView { }

class TableViewCellNib: UITableViewCell {
    
    @IBOutlet weak var outlet: UIButton!
}

class TableViewHeaderFooterViewNib: UITableViewHeaderFooterView {
    
    @IBOutlet weak var outlet: UIButton!
}

class CollectionViewCellNib: UICollectionViewCell {
    
    @IBOutlet weak var outlet: UIButton!
}

class CollectionReusableViewNib: UICollectionReusableView {
    
    @IBOutlet weak var outlet: UIButton!
}
