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
    fileprivate let albumsPathName = "Albums"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Archiver.shared.unarchive(pathName: albumsPathName) { [unowned self] (albums: [Album]?) in
            if let albums = albums {
                self.results = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        self.selectAlbum(indexPath: IndexPath(row: 0, section: 0))
                    }
                }
            }
        }
        searchController.searchBar.isHidden = false
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
        selectAlbum(indexPath: indexPath)
    }
    
    fileprivate func selectAlbum(indexPath: IndexPath) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            searchController.searchBar.isHidden = true
        }
        
        let selectedAlbum = results[indexPath.row]
        let albumVC = storyboard?.instantiateViewController(withIdentifier: AlbumDetailsViewControllerID) as! AlbumDetailsViewController
        albumVC.album = selectedAlbum
        let navVC = UINavigationController(rootViewController: albumVC)
        splitViewController?.showDetailViewController(navVC, sender: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        startLoader()
        guard let query = searchBar.text else { return }
        
        NetworkManager.shared.find(term: query) { [unowned self] (responseResults) in
            self.results = responseResults
            
            DispatchQueue.global().async {
                Archiver.shared.archive(items: self.results, pathName: self.albumsPathName)
            }
            
            DispatchQueue.main.async {
                self.stopLoader()
                self.tableView.reloadData()
                if UIDevice.current.userInterfaceIdiom == .pad {
                    self.selectAlbum(indexPath: IndexPath(row: 0, section: 0))
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}

