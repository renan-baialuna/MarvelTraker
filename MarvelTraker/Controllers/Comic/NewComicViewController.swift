//
//  NewComicViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 13/09/21.
//

import UIKit


class UnitComic {
    var base: BasicComic
    var image: UIImage
    
    init(base: BasicComic, image: UIImage) {
        self.base = base
        self.image = image
    }
}


class NewComicViewController: UIViewController {
    
    @IBOutlet weak var comicCollection: UICollectionView!
    @IBOutlet weak var warningView: UIView!
    
    var comics: [UnitComic] = []
    var selectedComic: Int = 0
    var target: String!
    var client: OTMClient = OTMClient()
    let alert = UIAlertController(title: "Error", message: "There was an error loading", preferredStyle: UIAlertController.Style.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningView.isHidden = true
        comicCollection.delegate = self
        comicCollection.dataSource = self
        getCaracter(name: target)
        
    }
    
    func setupAlert() {
        DispatchQueue.main.async {
            self.alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            self.present(self.alert, animated: true, completion: nil)
        }
    }
    
    func getCaracter(name: String) {
        self.view.activityStartAnimating()
        
        let hash = OTMClient().createHash()
        if let url = OTMClient().getEndpoint(type: .comic, target: target) {
            OTMClient.taskForGetRequest(url: url,  responseType: ComicResponse.self) { [self] (response, error) in
                self.view.activityStopAnimating()
                if error == nil {
                    if let results = response?.data.results {
                        if results.isEmpty {
                            warningView.isHidden = false
                        } else {
                            for i in results {
                                var newComic = UnitComic(base: client.translateAPI(base: i), image: .internalComicPlaceholder)
                                comics.append(newComic)
                                if i.images.count > 0 {
                                    
                                    
                                    getImage(comic: newComic)
                                }
                                comicCollection.reloadData()
                            }
                        }
                    }
                } else {
                    setupAlert()
                }
            }
        }
    }
    
    func getImage(comic: UnitComic) {
        let session = URLSession(configuration: .default)
        if let image = comic.base.cover {
            if let url = client.getEndpoint(data: image, size: .portrait_incredible) {
                let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    if error != nil {
                    }
                    if let safeData = data {
                        if let downloadedImage = UIImage(data: safeData) {
                            DispatchQueue.main.async { [self] in
                                comic.image = downloadedImage
                                comicCollection.reloadData()
                            }
                            
                        }
                    }
                }
                task.resume()
            }
        }
    }
}


extension NewComicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewComic", for: indexPath) as! NewComicCollectionViewCell
        let comic = self.comics[indexPath.row]
        
        
        cell.setup(title: comic.base.title, image: comic.image)
        
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
            
            vc.comic = comics[selectedComic].base
        }
    }
}

