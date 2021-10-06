//
//  NewCaracterViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 29/09/21.
//

import UIKit

class NewCaracterViewController: UIViewController {
    @IBOutlet weak var caracterCollection: UICollectionView!

    var mockCaracters: [BasicCharacter] = [BasicCharacter(id: "1", name: "nome", image: .internalCharaterPlaceholder, resume: "teste", creationDate: Date(), comics: ["primeiro", "segundo"], link: "www.apple.com")]
    
    var selectedIndex: Int = 0
    var caracters: [BasicCharacter] = []
    var target: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        caracterCollection.delegate = self
        caracterCollection.dataSource = self
        caracters = mockCaracters

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCaracter" {
            var vc = segue.destination as! CaracterDetailViewController
            vc.caracter = caracters[selectedIndex]
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
        cell.mainLabel.text = character.name
        
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
