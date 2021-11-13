//
//  NewComicCollectionViewCell.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 13/09/21.
//

import UIKit

class NewComicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    let identifier: String = "NewComic"
    
    public func setup(title: String, image: UIImage) {
        self.image.image = image
        self.title.text = title
        
        self.title.numberOfLines = 0
        self.title.adjustsFontSizeToFitWidth = true
        self.title.minimumScaleFactor = 0.2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
