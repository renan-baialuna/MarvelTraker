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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.wishListButton.configure(image: .internalWishIcon, title: "Whish List")
        self.inventoryListButton.configure(image: .internalCollectionIcon, title: "My Comics")
        getCaracter(name: "Morbius")
    }
    
    func getCaracter(name: String) {
        let hash = OTMClient().createHash()
        OTMClient.taskForGetRequest(url: OTMClient.Endpoints.getCaracter(name, hash).url,  responseType: CaracterResponse.self) { [self] (response, error) in
            if error == nil {
                print(response)
                if let results = response?.data.results {
                    for i in results {
                        print(i.name)
                    }
                }
                
                
            } else {
//
            }
        }
    }
    
    @IBAction func startSearch() {
        performSegue(withIdentifier: "toResults", sender: nil)
    }
    
    @IBAction func goWhish() {
        print("to Wish")
    }
    
    @IBAction func goComics() {
        performSegue(withIdentifier: "toInventory", sender: nil)
    }
 

}

