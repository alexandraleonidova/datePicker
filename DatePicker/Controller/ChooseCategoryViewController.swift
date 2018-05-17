//
//  ChooseCategoryViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova and Taylor Coury on 4/17/18.
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
        guard currDate != nil else{ return }
        
        switch sender {
            case nightlifeButton:
                currDate?.subCategories.append("nightlife")
            case activeLifeButton:
                currDate?.subCategories.append("activeLife")
            case artsButton:
                currDate?.subCategories.append("arts")
            case entertainmentButton:
                currDate?.subCategories.append("entertainment")
            case beautyAndSpaButton:
                currDate?.subCategories.append("beautyAndSpa")
            case internationalMealButton:
                currDate?.subCategories.append("internationalMeal")
            case americanMealButton:
                currDate?.subCategories.append("americanMeal")
            case dessertsAndSnacksMealButton:
                currDate?.subCategories.append("dessertsAndSnacksMeal")
            case otherMealButton:
                currDate?.subCategories.append("otherMeal")
            default:
                break
            }
            
            performSegue(withIdentifier: "toSetDetailsSegue", sender: nil)
    }
    
    var currDate: myDate?
    
    //this will be index of the date item we are currenctly dealing with (0 <= choiseIndex < mainCategories.count)
    var choiseIndex = 0
    var subcategoriesChosen: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI(){
        activityStack.isHidden = true
        mealStack.isHidden = true
        nightlifeStack.isHidden = true
        
        if let currDate = currDate{
            let currentCategory = currDate.mainCategories[choiseIndex]            
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
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toSetDetailsSegue" {
            let setDetailsViewController = segue.destination as! SetDetailsViewController
            
            setDetailsViewController.currDate = currDate
        }
    }
    
    @IBAction func unwindChooseCategory(unwindSegue: UIStoryboardSegue) {
        guard let setDetailsViewController = unwindSegue.source as? SetDetailsViewController, let recievedDate = setDetailsViewController.currDate, choiseIndex < recievedDate.mainCategories.count
            else { return }
        currDate = recievedDate
        choiseIndex += 1
        updateUI()
    }
    

}
