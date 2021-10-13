//
//  CaracterDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 29/09/21.
//

import UIKit

class CaracterDetailViewController: UIViewController {

    @IBOutlet weak var caracterImageButton: UIButton!
    @IBOutlet weak var caracterBioTextView: UITextView!
    @IBOutlet weak var comicsTable: UITableView!
    @IBOutlet weak var linkButton: UIButton!
    
    var caracter: BasicCharacter!
    var client: OTMClient = OTMClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicsTable.delegate = self
        comicsTable.dataSource = self

        
        caracterImageButton.setImage(.internalCharaterPlaceholder, for: .normal)
        
        setup()
    }
    
    func setup() {
        self.title = caracter.name
        caracterBioTextView.text = caracter.resume == "" ? "No Resume" : caracter.resume
        setupImage()
    }
    
    
    func setupImage() {
        let session = URLSession(configuration: .default)
        if let url = client.getEndpoint(data: caracter.image, size: .portrait_medium) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                }
                if let safeData = data {
                    if let downloadedImage = UIImage(data: safeData) {
                        DispatchQueue.main.async { [self] in
                            caracterImageButton.setImage(downloadedImage, for: .normal)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    @IBAction func toWebview() {
        performSegue(withIdentifier: "toWebview", sender: nil)
    }
    
    @IBAction func toImage() {
        performSegue(withIdentifier: "toImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebview" {
            let vc = segue.destination as! WebViewScreenViewController
            vc.urlString = caracter.link
        } else if segue.identifier == "toImage" {
            let vc = segue.destination as! ImageDetailViewController
            vc.newImage = caracter.image
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
