//
//  InventoryDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 04/10/21.
//

import UIKit

class InventoryDetailViewController: UIViewController {
    var comic: BasicComicInventory!
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
        setButton()
        setLupe()
        setData()
        
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
        titleLabel.text = comic.comic.title
        serieLabel.text = comic.comic.series
//        coverImageView.image = comic.comic.cover
        lanchDateLabel.text = "Lauch: \(comic.comic.launchDate.getDateString())"
        aditionDateLabel.text = "Aquisition \(comic.aquisitonDate.getDateString())"
        valueLabel.text = "price: \(comic.price)"
        conditionLabel.text = "conditional: \(comic.condition)"
        descriptionTextView.text = comic.comic.resume
    }
    
    func setLupe() {
        lupeImageView.image = lupeImageView.image?.withRenderingMode(.alwaysTemplate)
        lupeImageView.tintColor = .detail
    }
    

    @IBAction func goImage(_ sender: Any) {
        
        
        
    }
    
    @IBAction func removeAction(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you what to delete", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Delete immediately!", style: UIAlertAction.Style.default, handler: {_ in
            self.navigationController?.popToRootViewController(animated: true)
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
            
        }
    }
}
