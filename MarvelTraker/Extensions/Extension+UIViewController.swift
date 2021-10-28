//
//  Extension+UIViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 27/10/21.
//

import Foundation
import UIKit


extension UIViewController {
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
}
