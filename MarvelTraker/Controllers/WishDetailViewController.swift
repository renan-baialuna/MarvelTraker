//
//  InventoryDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 04/10/21.
//

import UIKit

class WishDetailViewController: UIViewController {
    var comic: BasicComic!
    
    @IBOutlet weak var imageBackView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var aquisitonButton: UIButton!
    @IBOutlet weak var lupeImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
        
        
    }
    
    func setup() {
        setLupe()
        setButton()
        setData()
    }
    
    func setData() {
        coverImageView.image = comic.cover
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
    
    @IBAction func selectImage(_ sender: Any) {
        
        performSegue(withIdentifier: "toImage", sender: nil)
    }
    
    @IBAction func aquisitonAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImage" {
            var vc = segue.destination as! ImageDetailViewController
            vc.image = comic.cover
        }
    }
}

