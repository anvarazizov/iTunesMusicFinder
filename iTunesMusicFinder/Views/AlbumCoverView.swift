//
//  AlbumCoverView.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 12.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import UIKit

class AlbumCoverView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    func setupXib() {
        UINib(nibName: "AlbumCoverView", bundle: nil).instantiate(withOwner: self, options: nil)
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func startLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
