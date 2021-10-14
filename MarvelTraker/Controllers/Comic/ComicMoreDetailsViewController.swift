//
//  ComicMoreDetailsViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 04/10/21.
//

import UIKit

class ComicMoreDetailsViewController: UIViewController {

    var comic: BasicComic!
    var client: OTMClient = OTMClient()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resumeTextView: UITextView!
    @IBOutlet weak var lanchDate: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        titleLabel.text = comic.title
        resumeTextView.text = comic.resume
        self.title = comic.title
        lanchDate.text = "Lauch: \(comic.launchDate.getDateString())"
        pageLabel.text = "Pages: \(comic.pages)"
        priceLabel.text = "Price: \(comic.value)"
        setupImage()
    }
    
    func setupImage() {
        
        let session = URLSession(configuration: .default)
        if let image = comic.cover {
            if let url = client.getEndpoint(data: image, size: .standard_xlarge) {
                let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    if error != nil {
                    }
                    if let safeData = data {
                        if let downloadedImage = UIImage(data: safeData) {
                            DispatchQueue.main.async { [self] in
                                imageButton.setImage(downloadedImage, for: .normal)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    @IBAction func toImage() {
        performSegue(withIdentifier: "toImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImage", let cover = comic.cover {
            var vc = segue.destination as!  ImageDetailViewController
            vc.newImage = cover
            vc.newTitle = comic.title
        }
    }
    
}
