//
//  Extension+Float.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 05/10/21.
//

import Foundation

extension Float {
    var getCondition: String {
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
        
        if self >= 10.0 {
            return allScale[allScale.count - 1].name
        } else {
            while allScale[index].value < self {
                index += 1
            }
            return allScale[index - 1].name
        }
    }
}
