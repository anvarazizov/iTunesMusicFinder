//
//  SplitViewController.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 12.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        preferredDisplayMode = .allVisible
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
