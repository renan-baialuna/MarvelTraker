//
//  ImageDetailViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 05/10/21.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            mainImage.image = image
        }
        // Do any additional setup after loading the view.
    }
    
}
