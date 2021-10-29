//
//  WhislistCollectionViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 05/10/21.
//

import UIKit
import CoreData

class UnitWishComic {
    var comic: BasicComic!
    var image: UIImage = .internalComicPlaceholder
    var base: MemoryWish
    init(comic: BasicComic, image: UIImage, base: MemoryWish) {
        self.comic = comic
        self.image = image
        self.base = base
    }
}

class WhislistCollectionViewController: UIViewController {

    var wishList: [UnitWishComic] = []
    var index: Int = 0

    var dataController: DataController!
    @IBOutlet weak var whishCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whishCollection.delegate = self
        whishCollection.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupDataController()
    }
    
    func setupDataController() {
        wishList = []
        let fetchRequest: NSFetchRequest<MemoryWish> = MemoryWish.fetchRequest()
        
        if let results = try? dataController.viewContext.fetch(fetchRequest) {
            for i in results {
                if let comic = i.getBasicComic() {
                    let unit = UnitWishComic(comic: comic, image: UIImage(data: (i.comic!.image!.image)!)!, base: i)
                    wishList.append(unit)
                }
            }
            whishCollection.reloadData()
        }
    }
}

extension WhislistCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        wishList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "whishCell", for: indexPath) as! WhishCollectionViewCell
        if let unitComic = wishList[indexPath.row].comic, !unitComic.creators.isEmpty {
            cell.authorLabel.text = unitComic.creators[0]
            cell.titleLabel.text = unitComic.title
        }
       
        
        cell.coverImage.image = wishList[indexPath.row].image
        
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
            vc.unitComic = wishList[index]
        }
        
        if segue.identifier == "toImage" {
            
        }
    }
    
}
