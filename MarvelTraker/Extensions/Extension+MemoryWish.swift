//
//  Extension+MemoryWish.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 19/10/21.
//

import Foundation

extension MemoryWish {
    func getBasicComic() -> BasicComic? {
        if let comic = self.comic {
            
            let imageFormat: ImageFormat = ImageFormat(path: self.comic?.image?.link ?? "", extensionFormat: self.comic?.image?.dataFormat ?? "")
            let id = Int(comic.comicId)
            let title = comic.title ?? ""
            let resume = comic.resume ?? ""
            let launchDate = self.comic?.lanch ?? Date()
            let link = self.comic?.link ?? ""
            let pages = Int(comic.pages) ?? 0
            let value = self.comic?.value ?? 0.0
            let series = self.comic?.series ?? ""
            
            var ret: BasicComic = BasicComic(id: id, title: title, resume: resume, cover: imageFormat, launchDate: launchDate, creators: [], link: link, pages: pages, value: value, series: series)
            return ret
        } else {
            return nil
        }
    }
}
