//
//  OTMClient.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 17/08/21.
//

import Foundation
import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

enum EndpointTypes {
    case caracter
    case comic
    case event
}

enum ImageSizes: String {
    case portrait_medium = "portrait_medium"
    case portrait_xlarge = "portrait_xlarge"
    case portrait_incredible = "portrait_incredible"
    case standard_large = "standard_large"
    case standard_xlarge = "standard_xlarge"
    case standard_amazing = "standard_amazing"
}



class OTMClient {
    struct hashStruct: Hashable {
        var ts: String
        var pivateKey: String
        var publicKey: String
    }
    
    struct Auth {
        static var publicKey: String = "1c79a97f46b5fa023c32b27c29e695fa"
        static var internalKey: String = "b67f10237c84afe08e1c846cbc6a12f7d3cb94bc"
    }
    
    var hash: String {
        let strBase =  "\(NSDate().timeIntervalSince1970)\(Auth.internalKey)\(Auth.publicKey)"
        return MD5(string: strBase)
    }
    
    public func getEndpoint(type: EndpointTypes, target: String) -> URL? {
        let baseUrl = "https://gateway.marvel.com:443/v1/public/"
        let baseImage = ""
        var urlString: String = ""
        var hash: String = createHash()
        
        switch type {
        case .comic:
            urlString = "\(baseUrl)comics?titleStartsWith=\(target)&ts=thesoer&apikey=\(Auth.publicKey)&hash=\(hash)"
        case .caracter:
            urlString = "\(baseUrl)characters?ts=thesoer&nameStartsWith=\(target)&orderBy=name&apikey=\(Auth.publicKey)&hash=\(hash)"
        case .event:
            urlString = "\(baseUrl)events?nameStartsWith=\(target)&ts=thesoer&apikey=\(Auth.publicKey)&hash=\(hash)"
        }
        
        return URL(string: urlString)
    }
    
    public func getEndpoint(data: ImageFormat, size: ImageSizes = .portrait_medium) -> URL? {
        
        return URL(string: "\(data.path)/\(size.rawValue).\(data.extensionFormat)")
    }
    
    public func translateAPI(base: ResultComic) -> BasicComic {
        var creators: [String] = []
        for i in base.creators.items {
            creators.append(i.name)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let newDate = dateFormatter.date(from: base.dates[0].date)!
        
        var image: ImageFormat? = nil
        if base.images.count > 0 {
            image = base.images[0]
        }
        
        return BasicComic(id: base.id,
                          title: base.title,
                          resume: base.description ?? "no resume given",
                          cover: image,
                          launchDate: newDate,
                          creators: creators,
                          link: base.resourceURI,
                          pages: base.pageCount,
                          value: base.prices[0].price,
                          series: base.series.name)
    }
    
    public func translateAPI(base: ResultEvent) -> BasicEvent {
        var creators: [String] = []
        for i in base.creators.items {
            creators.append(i.name)
        }
        
        var comicsId: [String] = []
        for i in base.comics.items {
            comicsId.append(i.name)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        
        var dates: String = "-"
        
        if let start = base.start, let end = base.start, let startDate = dateFormatter.date(from: start), let endDate = dateFormatter.date(from: end) {
            dates = "\(startDate.getDateString())-\(endDate.getDateString())"
        }
        
        let ret = BasicEvent(id: base.id,
                   title: base.title,
                   resume: base.description ?? "No Description",
                   cover: base.thumbnail,
                   dates: dates,
                   comicsIds: comicsId,
                   creators: creators)
        return ret
    }
    
    
    public func translateAPI(base: ResultCaracter) -> BasicCharacter {
        var comics: [String] = []
        for i in base.comics.items {
            comics.append(i.name)
        }
        
        return BasicCharacter(id: base.id,
                                 name: base.name,
                                 image: base.thumbnail,
                                 resume: base.resultDescription ?? "",
                                 comics: comics,
                                 link: base.resourceURI)
    }
    
    @discardableResult class func taskForGetRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping(ResponseType?, Error?) -> Void) -> URLSessionTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                var responseObject: ResponseType
                responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    completion(nil, error)
                }
            }
        }
        task.resume()
         return task
    }
    
    public func createHash() -> String {
        let strBase =  "thesoer\(Auth.internalKey)\(Auth.publicKey)"
        return MD5(string: strBase)
    }
    
    func MD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
                let messageData = string.data(using:.utf8)!
                var digestData = Data(count: length)

                _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                    messageData.withUnsafeBytes { messageBytes -> UInt8 in
                        if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                            let messageLength = CC_LONG(messageData.count)
                            CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                        }
                        return 0
                    }
                }
                return digestData.map { String(format: "%02hhx", $0) }.joined()

    }
    
    
    
}


