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
    
    private func itemsFilePath(named: String) -> String? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Path not found")
            return nil
        }
        return url.appendingPathComponent(named).path
    }
    
    func archive<T>(items: [T], pathName: String) {
        guard let path = itemsFilePath(named: pathName) else {
            print("Item file path is nil")
            return
        }
        NSKeyedArchiver.archiveRootObject(items, toFile: path)
    }
    
    func unarchive<T>(pathName: String, completion: @escaping (_ items: [T]?) -> ()) {
        guard let path = itemsFilePath(named: pathName) else {
            print("Item file path is nil")
            return
        }
        if let cachedItems = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [T] {
            completion(cachedItems)
        }
        completion(nil)
    }
}
