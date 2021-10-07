//
//  ComicResponse.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 06/10/21.
//

import Foundation


struct ComicResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClassComic
}


struct DataClassComic: Codable {
    let offset, limit, total, count: Int
    let results: [ResultComic]
}

struct ResultComic: Codable {
    let id: Int
    let title: String
    let description: String?
    let images: [ImageFormat]
    let dates: [DateFormat]
    let creators: Creators
    let resourceURI: String
    let pageCount: Int
    
    let prices: [PriceFormat]
    let series: SeriesFormat
}

struct ImageFormat: Codable {
    let path: String
    let extensionFormat: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionFormat = "extension"
    }
}

struct DateFormat: Codable {
    let type: String
    let date: String
}

struct Creators: Codable {
    let available: Int
    let items: [Creator]
}

struct Creator: Codable {
    let name: String
}

struct PriceFormat: Codable {
    let type: String
    let price: Float
}

struct SeriesFormat: Codable {
    let name: String
}

//
//struct BasicComic {
//    let id: String
//    let title: String
//    let resume: String
//    let cover: UIImage
//    let launchDate: Date
//    let creators: [String]
//    let link: String
//    let pages: Int
//    let value: Float
//    let series: String
//}
