//
//  CreatorTableViewCell.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 28/09/21.
//

import UIKit

class CreatorTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.backgroundColor = .secondary
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.detail.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
