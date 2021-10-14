//
//  NewCaracterViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 29/09/21.
//

import UIKit

class UnitCaracter {
    var base: BasicCharacter
    var image: UIImage
    
    init(base: BasicCharacter, image: UIImage) {
        self.base = base
        self.image = image
    }
}

class NewCaracterViewController: UIViewController {
    @IBOutlet weak var caracterCollection: UICollectionView!
    
    var client: OTMClient = OTMClient()
    var selectedIndex: Int = 0
    var caracters: [UnitCaracter] = []
    var target: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        caracterCollection.delegate = self
        caracterCollection.dataSource = self

        getCaracter(name: target)
    }
    
    func getCaracter(name: String) {
        let hash = OTMClient().createHash()
        if let url = OTMClient().getEndpoint(type: .caracter, target: name) {
            OTMClient.taskForGetRequest(url: url,  responseType: CaracterResponse.self) { [self] (response, error) in
                if error == nil {
                    if let results = response?.data.results {
                        for i in results {
                            var newCaracter = UnitCaracter(base: client.translateAPI(base: i), image: .internalEventPlaceholder)
                            caracters.append(newCaracter)
                            getImage(caracter: newCaracter)
                        }
                    }
                    caracterCollection.reloadData()
                } else {
    //
                }
            }
        }
    }
    
    func getImage(caracter: UnitCaracter) {
        let session = URLSession(configuration: .default)
        if let url = client.getEndpoint(data: caracter.base.image, size: .portrait_incredible) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                }
                if let safeData = data {
                    if let downloadedImage = UIImage(data: safeData) {
                        DispatchQueue.main.async { [self] in
                            caracter.image = downloadedImage
                            caracterCollection.reloadData()
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCaracter" {
            var vc = segue.destination as! CaracterDetailViewController
            vc.caracter = caracters[selectedIndex].base
        }
    }
    
}

extension NewCaracterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return caracters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "caracterCell", for: indexPath) as! CaracterCollectionViewCell
        let character = caracters[indexPath.row]
        cell.mainImage.image = character.image
        cell.mainLabel.text = character.base.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let with = self.caracterCollection.frame.width / 2 - 5
            let height = (self.caracterCollection.frame.height) / 2 - 5
        
        return CGSize(width: with, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "toCaracter", sender: nil)
    }
    
}
