//
//  ViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 17/08/21.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    let alert = UIAlertController(title: "Alert", message: "Please add some information to search", preferredStyle: UIAlertController.Style.alert)
    
    @IBOutlet weak var wishListButton: IconButton!
    @IBOutlet weak var inventoryListButton: IconButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupbackground()
        self.wishListButton.configure(image: .internalWishIcon, title: "Whish List")
        self.inventoryListButton.configure(image: .internalCollectionIcon, title: "My Comics")
        self.searchTextField.delegate = self
    }
    
    func setupButton() {
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor.detail.cgColor
    }
    
    func setupbackground() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
    }
    
    func setupAlert() {
        DispatchQueue.main.async {
            self.alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                
            }))
            self.present(self.alert, animated: true, completion: nil)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func startSearch() {
        if self.searchTextField.text != "" {
            performSegue(withIdentifier: "toResults", sender: nil)
        } else {
            setupAlert()
        }
        
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
        if segue.identifier == "toWhishlist" {
            var vc = segue.destination as! WhislistCollectionViewController
            vc.dataController = self.dataController
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() 
        return true
    }
}

