//
//  CaracterCollectionViewCell.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 29/09/21.
//

import UIKit

class CaracterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    
    public func setup(image: UIImage, title: String) {
        mainImage.image = image
        mainLabel.text = title
        
        self.mainLabel.numberOfLines = 0
        self.mainLabel.adjustsFontSizeToFitWidth = true
        self.mainLabel.minimumScaleFactor = 0.5
    }
}
