//
//  AlbumDetailsViewController.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 12.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumDetailsViewController: UITableViewController {

    // Static cells
    @IBOutlet weak var artistNameCell: UITableViewCell!
    @IBOutlet weak var collectionNameCell: UITableViewCell!
    @IBOutlet weak var primaryGenreNameCell: UITableViewCell!
    @IBOutlet weak var collectionPriceCell: UITableViewCell!
    @IBOutlet weak var trackCountCell: UITableViewCell!
    @IBOutlet weak var countryCell: UITableViewCell!
    @IBOutlet weak var releaseDateCell: UITableViewCell!
    @IBOutlet weak var copyrightCell: UITableViewCell!
    @IBOutlet weak var collectionExplicitnessCell: UITableViewCell!
    
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        refreshUI()
    }
    
    fileprivate func refreshUI() {
        title = album?.artistName ?? ""
        artistNameCell.textLabel?.text = album?.artistName ?? ""
        collectionNameCell.textLabel?.text = album?.collectionName ?? ""
        primaryGenreNameCell.textLabel?.text = album?.primaryGenreName ?? ""
        collectionPriceCell.textLabel?.text = "\(album?.collectionPrice ?? 0.0)" + (album?.currency ?? "")
        trackCountCell.textLabel?.text = "\(album?.trackCount ?? 0)"
        countryCell.textLabel?.text = album?.country ?? ""
        releaseDateCell.textLabel?.text = album?.releaseDate ?? ""
        copyrightCell.textLabel?.text = album?.copyright ?? ""
        collectionExplicitnessCell.textLabel?.text = album?.collectionExplicitness ?? ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let width = tableView.frame.width
        let headerView = AlbumCoverView(frame: CGRect(x: 0, y: 0, width: width, height: width))

        let size = Int(headerView.imageView.frame.width * UIScreen.main.scale)
        if  let album = album,
            let artworkStringURL = album.artworkUrl(size),
            let artworkURL = URL(string: artworkStringURL) {
            
            headerView.startLoader()
            headerView.imageView.sd_setImage(with: artworkURL, completed: { (_, error, _, _) in
                if error == nil {
                    headerView.stopLoader()
                }
            })
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width
    }
}
