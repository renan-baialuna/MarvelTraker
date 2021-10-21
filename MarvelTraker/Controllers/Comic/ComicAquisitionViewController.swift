//
//  ComicAquisitionViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 01/10/21.
//

import UIKit

class ComicAquisitionViewController: UIViewController {
    @IBOutlet weak var conditionSlide: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    
    var dataController: DataController!
    var comic: BasicComic!
    var numericalCondition: Float = 5.0
    var image: UIImage!
    
    
    var aditionDate: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        dataController = sceneDelegate.dataController
        
    }
    

    @IBAction func changePriceTextfield(_ sender: Any) {
        numericalCondition = stateField.text!.floatValue
        if numericalCondition >= 0 && numericalCondition <= 10 {
            conditionSlide.value = numericalCondition
        } else if numericalCondition > 10{
            numericalCondition = 10.0
            conditionSlide.value = 10.0
        } else {
            numericalCondition = 0.0
            conditionSlide.value = 0.0
        }
    }
    
    @IBAction func changePrice(_ sender: Any) {
        numericalCondition = conditionSlide.value
        stateField.text = String(format: "%.2f", numericalCondition)
        stateLabel.text = numericalCondition.getCondition
    }
    
    @IBAction func saveDate(_ sender: Any) {
        aditionDate = datePicker.date
    }
}



