//
//  ComicDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 16/09/21.
//

import UIKit

class ComicDetailViewController: UIViewController {
    
    var comic: BasicComic!
    
    
    @IBOutlet weak var comicImageButton: UIButton!
    @IBOutlet weak var authorsTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var whishButton: ContinueButton!
    @IBOutlet weak var aquisitonButton: ContinueButton!
    var client: OTMClient = OTMClient()
    var image: ImageFormat? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        authorsTable.delegate = self
        authorsTable.dataSource = self
        authorsTable.backgroundColor = .background
        
        whishButton.setup(text: "I Want this")
        aquisitonButton.setup(text: "A Have Aquired This!", true)
        setupImage()
        titleLabel.text = comic.title
        
        
        
    }
    
    func setupImage() {
        image = comic.cover
        let session = URLSession(configuration: .default)
        if let image = image {
            if let url = client.getEndpoint(data: image, size: .portrait_medium) {
                let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    if error != nil {
                    }
                    if let safeData = data {
                        if let downloadedImage = UIImage(data: safeData) {
                            DispatchQueue.main.async { [self] in
                                comicImageButton.setImage(downloadedImage, for: .normal)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }

    
    @IBAction func toInformation(_ sender: Any) {
        performSegue(withIdentifier: "toDetail", sender: nil)
        
    }
    
    
    @IBAction func goAquisiton() {
        performSegue(withIdentifier: "toAquisition", sender: nil)
    }
    
    @IBAction func addToWish(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func openImage() {
        if image != nil {
            performSegue(withIdentifier: "toImage", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let image = image {
            if segue.identifier == "toImage" {
                var vc = segue.destination as!  ImageDetailViewController
                vc.newImage = image
            }
        }
        if segue.identifier == "toDetail" {
            var vc = segue.destination as! ComicMoreDetailsViewController
            vc.comic = comic
        }
    }
}



extension ComicDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comic.creators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creatorCell") as? CreatorTableViewCell
        cell?.titleLabel.text = comic.creators[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
}
