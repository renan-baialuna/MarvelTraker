//
//  InventoryListViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 02/10/21.
//

import UIKit

class InventoryListViewController: UIViewController {
    @IBOutlet weak var comicsTable: UITableView!
    
    var inventory: [BasicComicInventory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsTable.delegate = self
        comicsTable.dataSource = self
        inventory.append(BasicComicInventory(comic: BasicComic(id: "q", title: "b", resume: "c", cover: .internalCaracterEmpty, launchDate: Date(), creators: [], link: "", value: 10.0), price: 20.0, aquisitonDate: Date(), condition: 5.0))

    }

}

extension InventoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventaryCell") as! InventoryTableViewCell
        let comic = inventory[indexPath.row]
        cell.comicImage.image = comic.comic.cover
        cell.nameLabel.text = comic.comic.title
        cell.dateLabel.text = comic.aquisitonDate.description
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return CGFloat(190)
    }

    
}
