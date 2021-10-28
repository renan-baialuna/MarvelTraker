//
//  ComicAquisitionViewController.swift
//  MarvelTraker
//
//  Created by Renan Baialuna on 01/10/21.
//

import UIKit
import CoreData

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
    var unitComic: UnitInventoryComic?
    
    var aditionDate: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let unit = unitComic {
            setInitialValues(base: unit.comic)
            
        }
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        dataController = sceneDelegate.dataController
        
    }
    
    func setInitialValues(base: BasicComicInventory) {
        conditionSlide.setValue(base.condition, animated: true)
        stateLabel.text = base.condition.getCondition
        datePicker.setDate(base.aquisitonDate, animated: true)
        stateField.text = base.condition.simplefy()
        valueTextField.text = base.price.simplefy()
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
    
    func addToInventory() {
        let comicInventory = MemoryInventory(context: dataController.viewContext)
        let newComic = MemoryComic(context: dataController.viewContext)
        let newComicImage = MemoryImage(context: dataController.viewContext)
        
        let comicImageFormat = comic.cover
        newComicImage.image = self.image.pngData()
        newComicImage.link = comicImageFormat?.path
        newComicImage.dataFormat = comicImageFormat?.extensionFormat
        newComic.image = newComicImage
        
        newComic.comicId = Int32(comic.id)
        newComic.lanch = comic.launchDate
        newComic.title = comic.title
        newComic.resume = comic.resume
        newComic.series = comic.series
        newComic.value = comic.value
        comicInventory.comic = newComic
        comicInventory.aditionDate = datePicker.date
        comicInventory.condition = conditionSlide.value
        comicInventory.value = valueTextField.text?.floatValue ?? 0.0
        try? dataController.viewContext.save()
        
    }
    
    func changeInventory() {
        
    }
    
    
    @IBAction func saveDate(_ sender: Any) {
        if let unit = unitComic {
            
            unit.base.aditionDate = datePicker.date
            unit.base.condition = conditionSlide.value
            unit.base.value = valueTextField.text?.floatValue ?? 0.0
            try? dataController.viewContext.save()
            
            self.popBack(3)
            
        } else if comic != nil{
            addToInventory()
            navigationController?.popViewController(animated: true)
        }
       
        
        
    }
}


