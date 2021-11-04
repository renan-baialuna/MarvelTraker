//
//  InventoryDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 04/10/21.
//

import UIKit
import CoreData

class InventoryDetailViewController: UIViewController {
    var unitComic: UnitInventoryComic!
    var dataController: DataController!
    var client: OTMClient = OTMClient()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serieLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var lupeImageView: UIImageView!
    @IBOutlet weak var lanchDateLabel: UILabel!
    @IBOutlet weak var aditionDateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        dataController = sceneDelegate.dataController
        
        
        setButton()
        setLupe()
        setData()
        setupImage()
    }
    
    func setButton() {
        removeButton.backgroundColor = .selection
        removeButton.layer.cornerRadius = 10
        removeButton.layer.borderWidth = 2
        
        removeButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 20)
        removeButton.backgroundColor = .selection
        removeButton.setTitleColor(.detail, for: .normal)
        removeButton.layer.borderColor = UIColor.detail.cgColor
    }
    
    func setData() {
        titleLabel.text = unitComic.comic.comic.title
        serieLabel.text = unitComic.comic.comic.series
        lanchDateLabel.text = "Lauch: \(unitComic.comic.comic.launchDate.getDateString())"
        aditionDateLabel.text = "Aquisition \(unitComic.comic.aquisitonDate.getDateString())"
        valueLabel.text = "price: $\(unitComic.comic.price)"
        conditionLabel.text = "condition: \(unitComic.comic.condition.simplefy())"
        descriptionTextView.text = unitComic.comic.comic.resume
    }
    
    func setLupe() {
        lupeImageView.image = lupeImageView.image?.withRenderingMode(.alwaysTemplate)
        lupeImageView.tintColor = .detail
    }
    
    
    func setupImage() {
        
        let session = URLSession(configuration: .default)
        if let image = unitComic.comic.comic.cover {
            if let url = client.getEndpoint(data: image, size: .portrait_incredible) {
                let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    if error != nil {
                        DispatchQueue.main.async {
                            self.coverImageView.image = self.unitComic.image
                        }
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

    @IBAction func goImage(_ sender: Any) {
        performSegue(withIdentifier: "toImage", sender: nil)
    }
    
    @IBAction func removeAction(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you what to delete", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Delete immediately!", style: UIAlertAction.Style.default, handler: {_ in
            let inventoryToDelete = self.unitComic.base
            self.dataController.viewContext.delete(inventoryToDelete)
            try? self.dataController.viewContext.save()
            self.popBack(2)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel deletion", style: UIAlertAction.Style.cancel, handler: {_ in
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editButton(_ sender: Any) {
        performSegue(withIdentifier: "toEdition", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdition" {
            var vc = segue.destination as!  ComicAquisitionViewController
            vc.unitComic = unitComic
            vc.typeEntrance = .modification
        }
        
        if segue.identifier == "toImage" {
            var vc = segue.destination as!  ImageDetailViewController
            vc.newImage = unitComic.comic.comic.cover!
            vc.newTitle = unitComic.comic.comic.title
            vc.offlineImage = self.unitComic.image
        }
    }
}
