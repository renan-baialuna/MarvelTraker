//
//  NewEventViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 28/09/21.
//

import UIKit

class NewEventViewController: UIViewController {
    
    var events: [BasicEvent] = [BasicEvent(id: "1", title: "title", resume: "resume", cover: .internalCaracterFull, dates: "start date - end date", comicsIds: ["primeiro", "segundo"], creators: ["primeiro autor", "segundo Autor"])]

    @IBOutlet weak var eventTable: UITableView!
    var selectedEvent: Int = 0
    var target: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.dataSource = self
        eventTable.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
}

extension NewEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventTableViewCell
        let event = events[indexPath.row]
        cell.coverImage.image = event.cover
        cell.textField.text = event.resume
        cell.titleLabel.text = event.title
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return CGFloat(UIScreen.main.bounds.width / 2 + 100)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedEvent = indexPath.row
        performSegue(withIdentifier: "toEventDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetail" {
            var vc = segue.destination as! EventDetailViewController
            vc.event = events[selectedEvent]
            
            
        }
    }
    
}
