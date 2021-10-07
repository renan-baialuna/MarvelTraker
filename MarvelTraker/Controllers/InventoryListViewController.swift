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
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsTable.delegate = self
        comicsTable.dataSource = self
//        inventory.append(BasicComicInventory(comic: BasicComic(id: "q", title: "b", resume: "c", cover: .internalCaracterEmpty, launchDate: Date(), creators: [], link: "", pages: 100, value: 10.0, series: "the incredible"), price: 20.0, aquisitonDate: Date(), condition: 5.0))

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
        cell.dateLabel.text = comic.aquisitonDate.getDateString()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        selectedIndex = indexPath.row
        
        return CGFloat(190)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            var vc = segue.destination as! InventoryDetailViewController
            vc.comic = inventory[selectedIndex]
        }
    }

    
}
