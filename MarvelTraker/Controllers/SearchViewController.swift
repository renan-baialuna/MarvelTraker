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
    
    @IBOutlet weak var lastSearchButton: UIButton!
    @IBOutlet weak var wishListButton: IconButton!
    @IBOutlet weak var inventoryListButton: IconButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    var dataController: DataController!
    let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupbackground()
        setupAlert()
        self.wishListButton.configure(image: .internalWishIcon, title: "Whish List")
        self.inventoryListButton.configure(image: .internalCollectionIcon, title: "My Comics")
        self.searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchButton(last: sceneDelegate.getLastSearch())
        searchTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
            
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupSearchButton(last: String?) {
        if let last = last {
            if !last.isEmpty {
                lastSearchButton.isHidden = false
                lastSearchButton.setTitle("last search: \(last)", for: .normal)
            } else {
                lastSearchButton.isHidden = true
            }
        } else {
            lastSearchButton.isHidden = true
        }
    }
    
    @IBAction func bringSearch() {
        searchTextField.text = sceneDelegate.getLastSearch()
        lastSearchButton.isHidden = true
    }
    
    @IBAction func startSearch() {
        if self.searchTextField.text != "" {
            sceneDelegate.setLastSearch(search: searchTextField.text!)
            performSegue(withIdentifier: "toResults", sender: nil)
        } else {
            self.present(self.alert, animated: true, completion: nil)
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

