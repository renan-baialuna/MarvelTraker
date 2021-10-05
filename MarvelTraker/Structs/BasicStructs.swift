//
//  BasicStructs.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 13/09/21.
//

import Foundation
import UIKit

struct BasicComic {
    let id: String
    let title: String
    let resume: String
    let cover: UIImage
    let launchDate: Date
    let creators: [String]
    let link: String
    let pages: Int
    let value: Float
    let series: String
}

struct BasicEvent {
    let id: String
    let title: String
    let resume: String
    let cover: UIImage
    let dates: String
    let comicsIds: [String]
    let creators: [String]
}

struct BasicCharacter {
    let id: String
    let name: String
    let image: UIImage
    let resume: String
    let creationDate: Date
    let comics: [String]
    let link: String
    
}

struct BasicComicInventory {
    let comic: BasicComic
    let price: Float
    let aquisitonDate: Date
    let condition: Float
    
}

