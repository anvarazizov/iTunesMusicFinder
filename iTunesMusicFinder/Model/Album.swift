//
//  Album.swift
//  iTunesMusicFinder
//
//  Created by Anvar Azizov on 11.10.17.
//  Copyright © 2017 Anvar Azizov. All rights reserved.
//

import UIKit
import ObjectMapper

class Album: NSObject, NSCoding, Mappable {
    
    var collectionType: String?
    var artistId: String?
    var collectionId: String?
    var amgArtistId: String?
    var artistName: String?
    var collectionName: String?
    var collectionCensoredName: String?
    var artistViewUrl: String?
    var collectionViewUrl: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var collectionPrice: Double?
    var collectionExplicitness: String?
    var contentAdvisoryRating: String?
    var trackCount: Int?
    var copyright: String?
    var country: String?
    var currency: String?
    var releaseDate: String? // "2012-01-01T08:00:00Z"
    var primaryGenreName: String?
    
    struct Keys {
        static let collectionType = "collectionType"
        static let artistId = "artistId"
        static let collectionId = "collectionId"
        static let amgArtistId = "amgArtistId"
        static let artistName = "artistName"
        static let collectionName = "collectionName"
        static let collectionCensoredName = "collectionCensoredName"
        static let artistViewUrl = "artistViewUrl"
        static let collectionViewUrl = "collectionViewUrl"
        static let artworkUrl60 = "artworkUrl60"
        static let artworkUrl100 = "artworkUrl100"
        static let collectionPrice = "collectionPrice"
        static let collectionExplicitness = "collectionExplicitness"
        static let contentAdvisoryRating = "contentAdvisoryRating"
        static let trackCount = "trackCount"
        static let copyright = "copyright"
        static let country = "country"
        static let currency = "currency"
        static let releaseDate = "releaseDate"
        static let primaryGenreName = "primaryGenreName"
    }
    
    override init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        collectionType <- map["collectionType"]
        artistId <- map["artistId"]
        collectionId <- map["collectionId"]
        amgArtistId <- map["amgArtistId"]
        artistName <- map["artistName"]
        collectionName <- map["collectionName"]
        collectionCensoredName <- map["collectionCensoredName"]
        artistViewUrl <- map["artistViewUrl"]
        collectionViewUrl <- map["collectionViewUrl"]
        artworkUrl60 <- map["artworkUrl60"]
        artworkUrl100 <- map["artworkUrl100"]
        collectionPrice <- map["collectionPrice"]
        collectionExplicitness <- map["collectionExplicitness"]
        contentAdvisoryRating <- map["contentAdvisoryRating"]
        trackCount <- map["trackCount"]
        copyright <- map["copyright"]
        country <- map["country"]
        currency <- map["currency"]
        releaseDate <- map["releaseDate"]
        primaryGenreName <- map["primaryGenreName"]
    }
    
    func artworkUrl(_ sideSize: Int) -> String? {
        if let artwork = self.artworkUrl100 {
            return artwork.replacingOccurrences(of: "100x100bb", with: "\(sideSize)x\(sideSize)bb", options: .caseInsensitive, range: nil)
        }
        return nil
    }
    
    required init(coder decoder: NSCoder) {
        if let collectionTypeObject = decoder.decodeObject(forKey: Keys.collectionType) as? String {
            self.collectionType = collectionTypeObject
        }
        if let artistIdObject = decoder.decodeObject(forKey: Keys.artistId) as? String {
            self.artistId = artistIdObject
        }
        if let collectionIdObject = decoder.decodeObject(forKey: Keys.collectionId) as? String {
            self.collectionId = collectionIdObject
        }
        if let amgArtistIdObject = decoder.decodeObject(forKey: Keys.amgArtistId) as? String {
            self.amgArtistId = amgArtistIdObject
        }
        if let artistNameObject = decoder.decodeObject(forKey: Keys.artistName) as? String {
            self.artistName = artistNameObject
        }
        if let collectionNameObject = decoder.decodeObject(forKey: Keys.collectionName) as? String {
            self.collectionName = collectionNameObject
        }
        if let collectionCensoredNameObject = decoder.decodeObject(forKey: Keys.collectionCensoredName) as? String {
            self.collectionCensoredName = collectionCensoredNameObject
        }
        if let artistViewUrlObject = decoder.decodeObject(forKey: Keys.artistViewUrl) as? String {
            self.artistViewUrl = artistViewUrlObject
        }
        if let collectionViewUrlObject = decoder.decodeObject(forKey: Keys.collectionViewUrl) as? String {
            self.collectionViewUrl = collectionViewUrlObject
        }
        if let artworkUrl60Object = decoder.decodeObject(forKey: Keys.artworkUrl60) as? String {
            self.artworkUrl60 = artworkUrl60Object
        }
        if let artworkUrl100Object = decoder.decodeObject(forKey: Keys.artworkUrl100) as? String {
            self.artworkUrl100 = artworkUrl100Object
        }
        if let collectionPriceObject = decoder.decodeObject(forKey: Keys.collectionPrice) as? Double {
            self.collectionPrice = collectionPriceObject
        }
        if let collectionExplicitnessObject = decoder.decodeObject(forKey: Keys.collectionExplicitness) as? String {
            self.collectionExplicitness = collectionExplicitnessObject
        }
        if let contentAdvisoryRatingObject = decoder.decodeObject(forKey: Keys.contentAdvisoryRating) as? String {
            self.contentAdvisoryRating = contentAdvisoryRatingObject
        }
        if let trackCountObject = decoder.decodeObject(forKey: Keys.trackCount) as? Int {
            self.trackCount = trackCountObject
        }
        if let copyrightObject = decoder.decodeObject(forKey: Keys.copyright) as? String {
            self.copyright = copyrightObject
        }
        if let countryObject = decoder.decodeObject(forKey: Keys.country) as? String {
            self.country = countryObject
        }
        if let currencyObject = decoder.decodeObject(forKey: Keys.currency) as? String {
            self.currency = currencyObject
        }
        if let releaseDateObject = decoder.decodeObject(forKey: Keys.releaseDate) as? String {
            self.releaseDate = releaseDateObject
        }
        if let primaryGenreNameObject = decoder.decodeObject(forKey: Keys.primaryGenreName) as? String {
            self.primaryGenreName = primaryGenreNameObject
        }
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(collectionType, forKey: Keys.collectionType)
        coder.encode(artistId, forKey: Keys.artistId)
        coder.encode(collectionId, forKey: Keys.collectionId)
        coder.encode(amgArtistId, forKey: Keys.amgArtistId)
        coder.encode(collectionName, forKey: Keys.collectionName)
        coder.encode(artistName, forKey: Keys.artistName)
        coder.encode(collectionCensoredName, forKey: Keys.collectionCensoredName)
        coder.encode(artistViewUrl, forKey: Keys.artistViewUrl)
        coder.encode(collectionViewUrl, forKey: Keys.collectionViewUrl)
        coder.encode(artworkUrl60, forKey: Keys.artworkUrl60)
        coder.encode(artworkUrl100, forKey: Keys.artworkUrl100)
        coder.encode(collectionPrice, forKey: Keys.collectionPrice)
        coder.encode(collectionExplicitness, forKey: Keys.collectionExplicitness)
        coder.encode(contentAdvisoryRating, forKey: Keys.contentAdvisoryRating)
        coder.encode(trackCount, forKey: Keys.trackCount)
        coder.encode(copyright, forKey: Keys.copyright)
        coder.encode(country, forKey: Keys.country)
        coder.encode(currency, forKey: Keys.currency)
        coder.encode(releaseDate, forKey: Keys.releaseDate)
        coder.encode(primaryGenreName, forKey: Keys.primaryGenreName)
    }
}
