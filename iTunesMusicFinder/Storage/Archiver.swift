//
//  Archiver.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 13.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import Foundation

class Archiver {
    static let shared = Archiver()
    
    private func itemsFilePath(named: String) -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent(named).path)
    }
    
    func archive<T>(items: [T], pathName: String) {
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsFilePath(named: pathName))
    }
    
    func unarchive<T>(pathName: String, completion: @escaping (_ items: [T]?) -> ()) {
        if let cachedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemsFilePath(named: pathName)) as? [T] {
            completion(cachedItems)
        }
        completion(nil)
    }
}
