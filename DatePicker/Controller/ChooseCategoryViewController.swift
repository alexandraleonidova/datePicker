//
//  ChooseCategoryViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit

class ChooseCategoryViewController: UIViewController {
    
    @IBOutlet weak var nightlifeButton: UIButton!
    
    @IBOutlet weak var activeLifeButton: UIButton!
    @IBOutlet weak var artsButton: UIButton!
    @IBOutlet weak var entertainmentButton: UIButton!
    @IBOutlet weak var beautyAndSpaButton: UIButton!
    
    @IBOutlet weak var internationalMealButton: UIButton!
    @IBOutlet weak var americanMealButton: UIButton!
    @IBOutlet weak var dessertsAndSnacksMealButton: UIButton!
    @IBOutlet weak var otherMealButton: UIButton!
    
    @IBOutlet weak var nightlifeStack: UIStackView!
    @IBOutlet weak var activityStack: UIStackView!
    @IBOutlet weak var mealStack: UIStackView!
    
    @IBAction func chooseSubCategoryButtonPressed(_ sender: UIButton) {
        switch sender {
        case nightlifeButton:
            subcategoriesChosen.append("nightlife")
        case activeLifeButton:
            subcategoriesChosen.append("activeLife")
        case artsButton:
            subcategoriesChosen.append("arts")
        case entertainmentButton:
            subcategoriesChosen.append("entertainment")
        case beautyAndSpaButton:
            subcategoriesChosen.append("beautyAndSpa")
        case internationalMealButton:
            subcategoriesChosen.append("internationalMeal")
        case americanMealButton:
            subcategoriesChosen.append("americanMeal")
        case dessertsAndSnacksMealButton:
            subcategoriesChosen.append("dessertsAndSnacksMeal")
        case otherMealButton:
            subcategoriesChosen.append("otherMeal")
        default:
            break
        }
        
        performSegue(withIdentifier: "toSetDetailsSegue", sender: nil)
    }
    
    //this is data from the main screen
    var mainCategories: [String] = []
    var chooseCurrentLocation = false
    var address: String = ""
    
    //this is data from set Details Screen
    var dateItemsArray: [DateItem] = []
    
    //this will be index of the date item we are currenctly dealing with (0 <= choiseIndex < mainCategories.count)
    var choiseIndex = 0
    var subcategoriesChosen: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //debug
        print("In ChooseCategoryViewController")
        print(mainCategories)
        print(chooseCurrentLocation)
        print(address)
        
        //TODO: if chooseCurrentLocation == true => get geolocation (Alex)
        
        // Do any additional setup after loading the view.
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        activityStack.isHidden = true
        mealStack.isHidden = true
        nightlifeStack.isHidden = true
        
        let currentCategory = mainCategories[choiseIndex]
        
        switch currentCategory{
        case "Activity":
            activityStack.isHidden = false
        case "Meal":
            mealStack.isHidden = false
        case "Nightlife":
            nightlifeStack.isHidden = false
        default:
            fatalError("Recieved Invalid Activity from Main Scree")
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toSetDetailsSegue" {
            let setDetailsViewController = segue.destination as! SetDetailsViewController
            
            setDetailsViewController.recievedSubCategory = subcategoriesChosen.last!
            setDetailsViewController.dateItemsArray = dateItemsArray
        }
    }
    

}
