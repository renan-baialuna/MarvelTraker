//
//  ImageDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 05/10/21.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    var newTitle: String! = ""
    var newImage = ImageFormat(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73", extensionFormat: "jpg")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = newTitle
        if let url = OTMClient().getEndpoint(data: newImage, size: .portrait_incredible) {
            getImage(url: url)
        }
        
        
    }
    
    func getImage(url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
            }
            if let safeData = data {
                if let downloadedImage = UIImage(data: safeData) {
                    DispatchQueue.main.async {
                        self.mainImage.image = downloadedImage
                    }
                }
            }
        }
        task.resume()
    }
}
