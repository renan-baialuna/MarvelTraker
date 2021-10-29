//
//  InventoryDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 04/10/21.
//

import UIKit

class WishDetailViewController: UIViewController {
    var comic: BasicComic!
    var unitComic: UnitWishComic!
    var dataController: DataController!
    var oldImage: UIImage?
    
    @IBOutlet weak var imageBackView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var aquisitonButton: UIButton!
    @IBOutlet weak var lupeImageView: UIImageView!
    var client: OTMClient = OTMClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comic = unitComic.comic
        oldImage = unitComic.image
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        dataController = sceneDelegate.dataController
        setup()
    }
    
    func setup() {
        setLupe()
        setButton()
        setData()
        setupImage()
    }
    
    func setData() {
        pagesLabel.text = "pages \(comic.pages)"
        launchDateLabel.text = "release date: \(comic.launchDate.getDateString())"
        seriesLabel.text = comic.series
        priceLabel.text = "price: \(String(format: "%.2f", comic.value))"
        descriptionTextView.text = comic.resume

    }
    
    func setLupe() {
        lupeImageView.image = lupeImageView.image?.withRenderingMode(.alwaysTemplate)
        lupeImageView.tintColor = .detail
    }
    
    func setButton() {
        aquisitonButton.backgroundColor = .selection
        aquisitonButton.layer.cornerRadius = 10
        aquisitonButton.layer.borderWidth = 2
        
        aquisitonButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 20)
        aquisitonButton.backgroundColor = .selection
        aquisitonButton.setTitleColor(.detail, for: .normal)
        aquisitonButton.layer.borderColor = UIColor.detail.cgColor
    }
    
    func deleteFromWish() {
        let inventoryToDelete = self.unitComic.base
        self.dataController.viewContext.delete(inventoryToDelete)
        try? self.dataController.viewContext.save()
        self.popBack(2)
    }
    
    func setupImage() {
        let image = comic.cover
        let session = URLSession(configuration: .default)
        if let image = image {
            if let url = client.getEndpoint(data: image, size: .portrait_incredible) {
                let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    if error != nil {
                        self.coverImageView.image = self.oldImage ?? .internalComicPlaceholder
                    }
                    if let safeData = data {
                        if let downloadedImage = UIImage(data: safeData) {
                            DispatchQueue.main.async { [self] in
                                coverImageView.image = downloadedImage
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    @IBAction func deleteWish() {
        deleteFromWish()
    }
    
    @IBAction func selectImage(_ sender: Any) {
        
        performSegue(withIdentifier: "toImage", sender: nil)
    }
    
    @IBAction func aquisitonAction(_ sender: Any) {
//        navigationController?.popToRootViewController(animated: true)
        performSegue(withIdentifier: "toAquisition", sender: nil)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImage" {
            var vc = segue.destination as! ImageDetailViewController
            vc.newImage = comic.cover!
        }
        
        if segue.identifier == "toAquisition" {
            var vc = segue.destination as! ComicAquisitionViewController
            vc.typeEntrance = .aditionWish
            vc.unitWish = self.unitComic
            vc.image = coverImageView.image
            
        }
    }
}

