//
//  EventDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 28/09/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    var event: BasicEvent!
    var client: OTMClient = OTMClient()
    
    @IBOutlet weak var creatorsTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var resumeTextView: UITextView!
    @IBOutlet weak var coverImageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverImageButton.setImage(.internalEventPlaceholder, for: .normal)
        creatorsTable.dataSource = self
        creatorsTable.delegate = self
        setup()
        
    }
    
    func setup() {
        resumeTextView.text = event.resume
        self.title = event.title
        self.dateLabel.text = event.dates
        setupImage()
        
    }
    
    func setupImage() {
        let session = URLSession(configuration: .default)
        if let url = client.getEndpoint(data: event.cover, size: .standard_xlarge) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                }
                if let safeData = data {
                    if let downloadedImage = UIImage(data: safeData) {
                        DispatchQueue.main.async { [self] in
                            coverImageButton.setImage(downloadedImage, for: .normal)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    @IBAction func toImage() {
        performSegue(withIdentifier: "toImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImage" {
            let vc = segue.destination as! ImageDetailViewController
            vc.newImage = event.cover
            vc.title = event.title
        }
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
