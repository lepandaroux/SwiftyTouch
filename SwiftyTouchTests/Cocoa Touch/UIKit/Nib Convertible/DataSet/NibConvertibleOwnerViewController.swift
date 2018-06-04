//
//  NibConvertibleOwnerViewController.swift
//  XDKitTests
//
//  Created by Xavier Leporcher on 06/04/2018.
//  Copyright © 2018 EI Xavier Leporcher. All rights reserved.
//

import UIKit
import SwiftyTouch

private let swiftyTouchTestsBundle = Bundle(for: ValidOwnerViewController.self)
private let nibFileName = "NibConvertibleOwnerViewController"

final class ValidOwnerViewController: UIViewController, NibOwnerViewController {
    
    static func nibFile() throws -> NibFileConvertible {
        return NibFile(nibFileName, bundle: swiftyTouchTestsBundle)
    }
    
    @IBOutlet weak var outlet: UIButton!
}
