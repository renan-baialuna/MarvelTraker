//
//  ContinueButton.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 22/09/21.
//

import Foundation
import UIKit

class ContinueButton: UIButton {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Baskerville-Bold", size: 15)
        
        return label
    }()
    
    func setup(text: String = "", _ isInversed: Bool = false) {
        mainLabel.text = text
        backgroundColor = .selection
        layer.cornerRadius = 10
        layer.borderWidth = 2
        
        if isInversed {
            mainLabel.textColor = .selection
            backgroundColor = .detail
            setTitleColor(.selection, for: .normal)
            layer.borderColor = UIColor.selection.cgColor
        } else {
            mainLabel.textColor = .detail
            backgroundColor = .selection
            setTitleColor(.detail, for: .normal)
            layer.borderColor = UIColor.detail.cgColor
        }
        addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: mainLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mainLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    public func configure(title: String) {
        self.mainLabel.text = title
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
}

