//
//  InventoryTableViewCell.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 02/10/21.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var conditionNumberLabel: UIView!
    @IBOutlet weak var valueLabel: UIView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup() {
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 2
        backView.layer.borderColor = UIColor.detail.cgColor
        
        conditionNumberLabel.layer.borderWidth = 4
        conditionNumberLabel.layer.borderColor = UIColor.selection.cgColor
        valueLabel.layer.borderWidth = 4
        valueLabel.layer.borderColor = UIColor.selection.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
