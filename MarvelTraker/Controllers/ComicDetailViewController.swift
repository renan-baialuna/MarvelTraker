//
//  ComicDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 16/09/21.
//

import UIKit

class ComicDetailViewController: UIViewController {
    
    var comic: BasicComic!
    
    
    @IBOutlet weak var comicImageButton: UIButton!
    @IBOutlet weak var authorsTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var whishButton: ContinueButton!
    @IBOutlet weak var aquisitonButton: ContinueButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        authorsTable.delegate = self
        authorsTable.dataSource = self
        authorsTable.backgroundColor = .background
        
        whishButton.setup(text: "I Want this")
        aquisitonButton.setup(text: "A Have Aquired This!", true)
        setupImage()
        
        titleLabel.text = comic.title
        
        
        
    }
    
    func setupImage() {
//        comicImageButton.setTitle("", for: .normal)
        comicImageButton.setImage(.internalComicPlaceholder, for: .normal)
    }
    
    @IBAction func openLink() {
        print("link")
    }
    
    @IBAction func toInformation(_ sender: Any) {
        performSegue(withIdentifier: "toDetail", sender: nil)
        
    }
    
    
    @IBAction func goAquisiton() {
        performSegue(withIdentifier: "toAquisition", sender: nil)
    }
 
    
}



extension ComicDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comic.creators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creatorCell") as? CreatorTableViewCell
        cell?.titleLabel.text = comic.creators[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
}
