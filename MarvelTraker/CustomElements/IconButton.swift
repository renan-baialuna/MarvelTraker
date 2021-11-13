//
//  IconButton.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 12/09/21.
//

import Foundation
import UIKit

class IconButton: UIButton {
    var defaultSize: CGFloat = 20
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Baskerville-Bold", size: 15)
        label.textColor = UIColor(named: "Detail")
        return label
    }()
    
    private let icon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .detail
        return image
    }()
    
    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        setup()
        self.configure(image: image, title: title)
    }
    
    private func setup() {
        
        backgroundColor = .secondary
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.detail.cgColor
        
        addSubview(icon)
        addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: mainLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: icon, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        icon.bottomAnchor.constraint(equalTo: mainLabel.topAnchor, constant: ( -1 * defaultSize)).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: defaultSize).isActive = true
        icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ( -1 * defaultSize)).isActive = true
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: defaultSize).isActive = true
    }
    
    public func configure(image: UIImage, title: String) {
        self.icon.image = image.withRenderingMode(.alwaysTemplate)
        self.mainLabel.text = title
        self.mainLabel.textAlignment = .center
        self.icon.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setup()
    }
}
