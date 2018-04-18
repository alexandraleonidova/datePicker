//
//  ChooseCategoryViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit

class ChooseCategoryViewController: UIViewController {
    
    @IBOutlet weak var nightlifeStack: UIStackView!
    @IBOutlet weak var activityStack: UIStackView!
    @IBOutlet weak var mealStack: UIStackView!
    
    //this is data from the main screen
    var mainCategories: [String] = []
    var chooseCurrentLocation = false
    var address: String = ""
    
    //this will be index of the date item we are currenctly dealing with (0 <= choiseIndex < mainCategories.count)
    var choiseIndex = 0

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
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
