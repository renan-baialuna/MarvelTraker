//
//  NewComicViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 13/09/21.
//

import UIKit

class mocks {
    public func mockComics() -> [BasicComic] {
        let mock: [BasicComic] = [BasicComic(id: "1", title: "Primeiro", resume: "resumo", cover: UIImage.internalAddIcon, launchDate: Date(), creators: ["first creator", "seccond creator"], link: "www.google.com", value: 12.50)]
        return mock
    }
}



class NewComicViewController: UIViewController {
    
    @IBOutlet weak var comicCollection: UICollectionView!
    
    var comics: [BasicComic] = mocks().mockComics()
    var selectedComic: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicCollection.delegate = self
        comicCollection.dataSource = self
        
    }
}


extension NewComicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewComic", for: indexPath) as! NewComicCollectionViewCell
        let comic = self.comics[indexPath.row]
        
        
        cell.setup(title: comic.title, image: comic.cover)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let with = ( self.view.frame.width  / 2 ) - 2
        let height = with * 1.5
        
            return CGSize(width: with, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedComic = indexPath.row
        performSegue(withIdentifier: "toComicDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComicDetails" {
            let vc = segue.destination as! ComicDetailViewController
            
            vc.comic = comics[selectedComic]
            
              
        }
    }
    
    
    
    
}
