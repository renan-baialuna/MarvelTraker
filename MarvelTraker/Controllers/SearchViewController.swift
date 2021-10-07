//
//  ViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 17/08/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var wishListButton: IconButton!
    @IBOutlet weak var inventoryListButton: IconButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        
        self.wishListButton.configure(image: .internalWishIcon, title: "Whish List")
        self.inventoryListButton.configure(image: .internalCollectionIcon, title: "My Comics")
    }
    
    func setupButton() {
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor.detail.cgColor
    }
    
    
    @IBAction func startSearch() {
        performSegue(withIdentifier: "toResults", sender: nil)
    }
    
    @IBAction func goWhish() {
        performSegue(withIdentifier: "toWhishlist", sender: nil)
    }
    
    @IBAction func goComics() {
        performSegue(withIdentifier: "toInventory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults" {
            var vc = segue.destination as! SearchTabBarController
            vc.target = searchTextField.text
            
        }
    }
 

}

