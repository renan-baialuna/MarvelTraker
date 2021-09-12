//
//  ViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 17/08/21.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var searchTextView: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
 

}

