//
//  EventDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 28/09/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    var event: BasicEvent!
    
    @IBOutlet weak var creatorsTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var resumeTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatorsTable.dataSource = self
        creatorsTable.delegate = self
        
        
    }
}


extension EventDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        event.creators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creatorCell") as? CreatorTableViewCell
        cell?.titleLabel.text = event.creators[indexPath.row]
        return cell!

    }
    
    
}
