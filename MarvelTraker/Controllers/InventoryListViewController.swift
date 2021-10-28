//
//  InventoryListViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 02/10/21.
//

import UIKit
import CoreData

class UnitInventoryComic {
    var comic: BasicComicInventory!
    var image: UIImage = .internalComicPlaceholder
    var base: MemoryInventory
    init(comic: BasicComicInventory, image: UIImage, base: MemoryInventory) {
        self.comic = comic
        self.image = image
        self.base = base
    }
}

class InventoryListViewController: UIViewController {
    @IBOutlet weak var comicsTable: UITableView!
    
    var inventory: [UnitInventoryComic] = []
    var selectedIndex: Int = 0
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsTable.delegate = self
        comicsTable.dataSource = self
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        dataController = sceneDelegate.dataController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDataController()
        self.comicsTable.reloadData()
    }
    
    func setupDataController() {
        inventory = []
        let fetchRequest: NSFetchRequest<MemoryInventory> = MemoryInventory.fetchRequest()
        
        if let results = try? dataController.viewContext.fetch(fetchRequest) {
            for i in results {
                var newImage: UIImage = .internalComicPlaceholder
                if let comic = i.getInventoryComic() {
                    if let temp = i.getImageData() {
                        if let image = UIImage(data: temp) {
                            newImage = image
                        }
                    }
                    let inventoryItem = UnitInventoryComic(comic: comic, image: newImage, base: i)
                    inventory.append(inventoryItem)
                }
            }
            comicsTable.reloadData()
        }
    }

}

extension InventoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventaryCell") as! InventoryTableViewCell
        let inventory = inventory[indexPath.row]
        cell.comicImage.image = inventory.image
        cell.nameLabel.text = inventory.comic.comic.title
        cell.dateLabel.text = inventory.comic.aquisitonDate.getDateString()
        cell.conditionNumberLabel.text = String(format: "%.2f", inventory.comic.condition)
        cell.conditionTextLabel.text = inventory.comic.condition.getCondition
        cell.valueLabel.text = "$\(inventory.comic.price)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        selectedIndex = indexPath.row
        
        return CGFloat(190)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            var vc = segue.destination as! InventoryDetailViewController
            vc.unitComic = inventory[selectedIndex]
        }
    }

    
}
