//
//  OTMClient.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 17/08/21.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

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
    
    enum Endpoints  {
        
        case getCaracter(String, String)
        
        var stringValue: String {
            let time = String(NSDate().timeIntervalSince1970)
            
            switch self {
            case .getCaracter(let name, let hash):
                return "https://gateway.marvel.com:443/v1/public/characters?ts=thesoer&name=\(name)&orderBy=name&apikey=\(Auth.publicKey)&hash=\(hash)"
            }
        }
        var url: URL {
            print(stringValue)
            return URL(string: stringValue)!
        }
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


