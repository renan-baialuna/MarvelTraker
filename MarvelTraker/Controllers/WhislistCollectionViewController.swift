//
//  WhislistCollectionViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 05/10/21.
//

import UIKit

class WhislistCollectionViewController: UIViewController {

    var wishList: [BasicComic] = []
    var index: Int = 0
    
    @IBOutlet weak var whishCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whishCollection.delegate = self
        whishCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension WhislistCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        wishList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "whishCell", for: indexPath) as! WhishCollectionViewCell
        let comic = wishList[indexPath.row]
        cell.authorLabel.text = comic.creators[0]
        cell.titleLabel.text = comic.title
        cell.coverImage.image = comic.cover
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        let frame = self.view.safeAreaLayoutGuide.layoutFrame

        let with = frame.width / 2 - 5
        let height = frame.height / 2 - 5
        
            return CGSize(width: with, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            var vc = segue.destination as! WishDetailViewController
            vc.comic = wishList[index]
        }
        
        if segue.identifier == "toImage" {
            
        }
    }
    
}
