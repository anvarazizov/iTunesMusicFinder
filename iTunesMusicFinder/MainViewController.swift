//
//  MainViewController.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 10.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UITableViewController {

    var results: [Album] = []
    
    fileprivate var searchController: UISearchController!
    fileprivate let activityIndicator = UIActivityIndicatorView()

    fileprivate let AlbumCellIdentifier = "albumCell"
    fileprivate let AlbumDetailsViewControllerID = "albumDetailsVC"
    
    var albumsFilePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Albums").path)
    }
    
    fileprivate func saveAlbums() {
        NSKeyedArchiver.archiveRootObject(results, toFile: albumsFilePath)
    }
    
    fileprivate func loadData() {
        if let cachedAlbums = NSKeyedUnarchiver.unarchiveObject(withFile: albumsFilePath) as? [Album] {
            results = cachedAlbums
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureSearchController()
        configureActivityIndicator()
    }
    
    fileprivate func configureActivityIndicator() {
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.isHidden = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    fileprivate func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = NSLocalizedString("Search here...", comment: "")
        searchController.searchBar.barTintColor = UIColor.clear
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = false
    }
    
    fileprivate func startLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    fileprivate func stopLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    // MARK: - UITableViewController Delegate & DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        if results.count > 0 {
            return 1
        }
        
        let noAlbumsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noAlbumsLabel.text = NSLocalizedString("No albums available. \nTry to search some. ", comment: "")
        noAlbumsLabel.numberOfLines = 2
        noAlbumsLabel.textColor = UIColor.white
        noAlbumsLabel.textAlignment = .center
        tableView.backgroundView = noAlbumsLabel
        tableView.separatorStyle = .none

        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if results.count > 0 {
            return results.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCellIdentifier, for: indexPath) as! AlbumTableViewCell
        
        let album = results[indexPath.row]
        cell.albumNameLabel.text = album.collectionName ?? ""
        cell.artistNameLabel.text = album.artistName ?? ""
        
        if let price = album.collectionPrice, let currency = album.currency {
            cell.priceLabel.text = "\(price) " + currency
        }
        
        if let imageUrlString = album.artworkUrl100, let url = URL(string: imageUrlString) {
            cell.startLoader()
            cell.coverImageView.sd_setImage(with: url, completed: { [unowned cell] (_, error, _, _) in
                if error == nil {
                    cell.stopLoader()
                }
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let albumDetailsVC = storyboard?.instantiateViewController(withIdentifier: AlbumDetailsViewControllerID) as? AlbumDetailsViewController {
            albumDetailsVC.album = results[indexPath.row]
            navigationController?.pushViewController(albumDetailsVC, animated: true)
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        startLoader()
        
        guard let query = searchBar.text else {
            return
        }
        
        NetworkManager.shared.find(term: query) { [unowned self] (responseResults) in
            self.results = responseResults
            self.saveAlbums()
            
            DispatchQueue.main.async {
                self.stopLoader()
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
}

