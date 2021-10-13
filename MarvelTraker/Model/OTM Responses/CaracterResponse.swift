//
//  CaracterResponse.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 12/10/21.
//

import Foundation

// MARK: - CaracterResponse
struct CaracterResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [ResultCaracter]
}

// MARK: - Result
struct ResultCaracter: Codable {
    let id: Int
    let name: String
    let resultDescription: String?
    let thumbnail: ImageFormat
    let resourceURI: String
    let comics, series: Comics
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

//// MARK: - Thumbnail
//struct Thumbnail: Codable {
//    let path: String
//    let thumbnailExtension: String
//
//    enum CodingKeys: String, CodingKey {
//        case path
//        case thumbnailExtension = "extension"
//    }
//}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}
