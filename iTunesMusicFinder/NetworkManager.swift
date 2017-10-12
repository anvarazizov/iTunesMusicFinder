//
//  NetworkManager.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 11.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import Foundation
import ObjectMapper

class NetworkManager {
    static let shared = NetworkManager()
    fileprivate let hostURLString = "https://itunes.apple.com/search?entity=album&term="
    
    func find(term: String, completionHandler: @escaping ([Album]) -> ()) {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        if  let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: hostURLString + encodedTerm) {
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard error == nil else {
                    print("error making request")
                    return
                }
                
                guard let responseData = data else {
                    print("Did not received data")
                    return
                }
                
                do {
                    guard let resultsDictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    
                    guard let resultsArray = resultsDictionary["results"] as? [[String : AnyObject]] else {
                        print("error receiving an array of results")
                        return
                    }
                   
                    var albums = [Album]()
                    for element in resultsArray {
                        if let album = Album(JSON: element) {
                            albums.append(album)
                        }
                    }
                    
                    completionHandler(albums)
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            })
            task.resume()
        }
    }
}
