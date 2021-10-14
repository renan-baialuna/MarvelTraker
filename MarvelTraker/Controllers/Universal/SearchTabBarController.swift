//
//  SearchTabBarController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 05/10/21.
//

import UIKit

class SearchTabBarController: UITabBarController {
    
    var target: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let vcEvent = self.viewControllers![1] as! NewEventViewController
        let vcComic = self.viewControllers![0] as! NewCaracterViewController
        let vcCaracter = self.viewControllers![2] as! NewComicViewController
        
        vcEvent.target = target
        vcComic.target = target
        vcCaracter.target = target
        super.viewWillAppear(animated)

    }
    
    

}
