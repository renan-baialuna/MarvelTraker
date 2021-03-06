//
//  Extension+Date.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 04/10/21.
//

import Foundation

extension Date {
    func getDateString() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMM dd, yyyy"
        
        return formater.string(from: self)
    }
}
