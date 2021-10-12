//
//  EventResponse.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 10/10/21.
//

import Foundation

struct EventResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClassEvent
}


struct DataClassEvent: Codable {
    let offset, limit, total, count: Int
    let results: [ResultEvent]
}

struct ResultEvent: Codable {
    let id: Int
    let title: String
    let description: String
    let start: String
    let end: String
    let thumbnail: ImageFormat
    let creators: Creators
    let comics: ComicItens
}

struct ComicItens: Codable {
    let items: [ComicItem]
}

struct ComicItem: Codable {
    let name: String
}
