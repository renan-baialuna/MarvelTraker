//
//  CaracterDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 29/09/21.
//

import UIKit

class CaracterDetailViewController: UIViewController {

    @IBOutlet weak var caracterImageView: UIImageView!
    @IBOutlet weak var caracterBioTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var creatorsTable: UITableView!
    @IBOutlet weak var linkButton: UIButton!
    
    var caracter: BasicCharacter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatorsTable.delegate = self
        creatorsTable.dataSource = self
        self.title = caracter.name
        caracterImageView.image = caracter.image
        caracterBioTextView.text = caracter.resume
        dateLabel.text = caracter.creationDate.description
//        linkButton.configure(image: .internalWishIcon, title: "Whish List")
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toWebview() {
        performSegue(withIdentifier: "toWebview", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebview" {
            let vc = segue.destination as! WebViewScreenViewController
            vc.urlString = caracter.link
        }
        
    }
}

extension CaracterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caracter.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creatorCell") as? CreatorTableViewCell
        cell?.titleLabel.text = caracter.comics[indexPath.row]
        return cell!
    }
    
    
}
