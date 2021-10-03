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
    var comic: BasicEvent!
    var numericalCondition: Float = 5.0
    
    
    var aditionDate: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getCondition(value: 9.95))
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
    }
    @IBAction func saveDate(_ sender: Any) {
        aditionDate = datePicker.date
    }
    
    func getCondition(value: Float) -> String {
        struct ConditionScale {
            let value: Float
            let name: String
        }
        
        var allScale: [ConditionScale] = []
        allScale.append(ConditionScale(value: 0.5, name: "PR Poor"))
        allScale.append(ConditionScale(value: 1.0, name: "FR Fair"))
        allScale.append(ConditionScale(value: 1.5, name: "FR/GD Fair/Good"))
        allScale.append(ConditionScale(value: 1.8, name: "GD- Good-"))
        allScale.append(ConditionScale(value: 2.0, name: "GD Good"))
        allScale.append(ConditionScale(value: 2.5, name: "GD+ Good+"))
        allScale.append(ConditionScale(value: 3.0, name: "GD/VG Good/Very Good"))
        allScale.append(ConditionScale(value: 3.5, name: "VG- Very Good-"))
        allScale.append(ConditionScale(value: 4.0, name: "VG Very Good"))
        allScale.append(ConditionScale(value: 4.5, name: "VG+ Very Good+"))
        allScale.append(ConditionScale(value: 5.0, name: "VG/FN Very Good/Fine"))
        allScale.append(ConditionScale(value: 5.5, name: "FN- Fine-"))
        allScale.append(ConditionScale(value: 6.0, name: "FN Fine"))
        allScale.append(ConditionScale(value: 6.5, name: "FN+ Fine+"))
        allScale.append(ConditionScale(value: 7.0, name: "FN/VF Fine/Very Fine"))
        allScale.append(ConditionScale(value: 7.5, name: "VF- Very Fine-"))
        allScale.append(ConditionScale(value: 8.0, name: "VF Very Fine"))
        allScale.append(ConditionScale(value: 8.5, name: "VF+ Very Fine+"))
        allScale.append(ConditionScale(value: 9.0, name: "VF/NM Very Fine/Near Mint"))
        allScale.append(ConditionScale(value: 9.2, name: "NM- Near Mint-"))
        allScale.append(ConditionScale(value: 9.4, name: "NM Near Mint"))
        allScale.append(ConditionScale(value: 9.6, name: "NM+ Near Mint+"))
        allScale.append(ConditionScale(value: 9.8, name: "NM/M Near Mint/Mint"))
        allScale.append(ConditionScale(value: 9.9, name: "M Mint"))
        allScale.append(ConditionScale(value: 10.0, name: "GM Gem Mint"))
        
        
        var index = 1
        
        if value >= 10.0 {
            return allScale[allScale.count - 1].name
        } else {
            while allScale[index].value < value {
                index += 1
            }
            return allScale[index - 1].name
        }
        

    }
    
    
    
    
    
}


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
