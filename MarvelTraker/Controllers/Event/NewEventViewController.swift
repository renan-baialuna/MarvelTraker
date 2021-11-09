//
//  NewEventViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 28/09/21.
//

import UIKit

class UnitEvent {
    var base: BasicEvent
    var image: UIImage
    
    init(base: BasicEvent, image: UIImage) {
        self.base = base
        self.image = image
    }
}


class NewEventViewController: UIViewController {
    
    var events: [UnitEvent] = []

    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var warningView: UIView!
    var selectedEvent: Int = 0
    var target: String!
    var client: OTMClient = OTMClient()
    let alert = UIAlertController(title: "Error", message: "There was an error loading", preferredStyle: UIAlertController.Style.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.dataSource = self
        eventTable.delegate = self
        getEvents(name: target)
        warningView.isHidden = true
        setupAlert()
    }
    
    func getEvents(name: String) {
        self.view.activityStartAnimating()
        let hash = OTMClient().createHash()
        if let url = OTMClient().getEndpoint(type: .event, target: name) {
            OTMClient.taskForGetRequest(url: url,  responseType: EventResponse.self) { [self] (response, error) in
                self.view.activityStopAnimating()
                if error == nil {
                    if let results = response?.data.results {
                        if results.isEmpty {
                            warningView.isHidden = false
                        } else {
                            for i in results {
                                var newEvent = UnitEvent(base: client.translateAPI(base: i), image: .internalEventPlaceholder)
                                events.append(newEvent)
                                getImage(event: newEvent)
                            }
                        }

                    }
                    self.reloadList()
                } else {
                    self.present(self.alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func getImage(event: UnitEvent) {
        let session = URLSession(configuration: .default)
        if let url = client.getEndpoint(data: event.base.cover, size: .standard_large) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    
                }
                if let safeData = data {
                    if let downloadedImage = UIImage(data: safeData) {
                        DispatchQueue.main.async { [self] in
                            event.image = downloadedImage
                            eventTable.reloadData()
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func setupAlert() {
        DispatchQueue.main.async {
            self.alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                self.navigationController?.popToRootViewController(animated: true)
            }))
        }
    }
    
    func reloadList() {
        DispatchQueue.main.async { [self] in
            self.eventTable.reloadData()
        }
    }
    
}

extension NewEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventTableViewCell
        let event = events[indexPath.row]
        cell.coverImage.image = event.image
        cell.textField.text = event.base.resume
        cell.titleLabel.text = event.base.title
        cell.dateLabel.text = event.base.dates
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
            vc.event = events[selectedEvent].base        }
    }
    
}
