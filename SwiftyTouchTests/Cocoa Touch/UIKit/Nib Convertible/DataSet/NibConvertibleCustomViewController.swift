//
//  NibConvertibleCustomViewController.swift
//  XDKitTests
//
//  Created by Xavier Leporcher on 13/04/2018.
//  Copyright © 2018 EI Xavier Leporcher. All rights reserved.
//

import UIKit
import SwiftyTouch

private let swiftyTouchTestsBundle = Bundle(for: ValidCustomViewController.self)
private let nibFileName = "NibConvertibleCustomViewController"

final class ValidCustomViewController: UIViewController, NibCustomViewController {
    
    static func nibFile() throws -> NibFileConvertible {
        return NibFile(nibFileName, bundle: swiftyTouchTestsBundle)
    }
    
    @IBOutlet weak var outlet: UIButton!
}
