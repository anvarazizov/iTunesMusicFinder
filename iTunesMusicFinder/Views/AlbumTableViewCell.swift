//
//  AlbumTableViewCell.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 11.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func startLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
