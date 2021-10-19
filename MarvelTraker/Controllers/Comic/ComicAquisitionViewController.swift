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
    
    func addToWish() {
        let comicWish = MemoryWish(context: dataController.viewContext)
        let newComic = MemoryComic(context: dataController.viewContext)
        let newComicImage = MemoryImage(context: dataController.viewContext)
        
        let comicImageFormat = comic.cover
        newComicImage.image = image.pngData()
        newComicImage.link = comicImageFormat?.path
        newComicImage.dataFormat = comicImageFormat?.extensionFormat
        newComic.image = newComicImage
        
        newComic.comicId = Int32(comic.id)
        newComic.lanch = comic.launchDate
        newComic.title = comic.title
        newComic.resume = comic.resume
        newComic.series = comic.series
        newComic.value = comic.value
//        todo: Add creator
        comicWish.comic = newComic
        
        
//        newComic.comicId = comic.id
        
        try? dataController.viewContext.save()
        
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
        addToWish()
    }
}



