//
//  SetDetailsViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit

class SetDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var mainCategoryLabel: UILabel!
    
    @IBOutlet weak var firstInterestPicker: UIPickerView!
    @IBOutlet weak var secondInterestPicker: UIPickerView!
    @IBOutlet weak var pricePicker: UIPickerView!
    
    //this is data from Coose Category Screen
    var currDate: myDate?
    
    var interestArray: [String] {
        if let currSubCategory = currDate?.subCategories.last {
            switch currSubCategory {
            case "nightlife":
                return nightlifeOptions
            case "activeLife":
                return activeLifeOptions
            case "arts":
                return artOptions
            case "entertainment":
                return entertainmentOptions
            case "beautyAndSpa":
                return beautyAndSpaOptions
            case "internationalMeal":
                return internationalMealOptions
            case "americanMeal":
                return americanMealOptions
            case "dessertsAndSnacksMeal":
                return dessertsAndSnacksMealOptions
            case "otherMeal":
                return otherMealOptions
            default:
                return []
            }
        }
        else{
            fatalError("Didnt recieve currDate at setDetailsViewController")
        }
    }
    
    //target categories arrays
    //TODO - move it to a model (and create model)
    var activeLifeOptions =    ["-",
                                "Airsoft",
                                "Archery",
                                "Amusement Parks",
                                "Aquariums",
                                "Batting Cages",
                                "Beaches",
                                "Bowling",
                                "Bungee Jumping",
                                "Carousels",
                                "Climbing",
                                "Escape Games",
                                "Flyboarding",
                                "Gokarts",
                                "Hiking",
                                "Horseback Riding",
                                "Hot Air Balloons",
                                "Jet Skis",
                                "Lasertag",
                                "Mini Golf",
                                "Paddleboarding",
                                "Paintball",
                                "Parks",
                                "Rock Climbing",
                                "Skating Rinks",
                                "Skydiving",
                                "Trampoline",
                                "Waterparks",
                                "Zipline",
                                "Zoos",
                                "Zorbing"
                                ]
    
    var artOptions =    ["-",
                        "Art Galleries",
                        "Jazz & Blues",
                        "Museums",
                        "Art Museums",
                        "Paint & Sip"]
    
    var entertainmentOptions = ["-",
                                "Arcades",
                                "Botanical Gardens",
                                "Movie Theaters",
                                "Attraction Farms",
                                "Psychics",
                                "Wine Tasting Room",
                                "Dinner Theater"
                                ]
    
    var beautyAndSpaOptions =  ["-",
                                "Day Spas",
                                "Hot Springs",
                                "Massage"
                                ]
    
    var internationalMealOptions = ["-",
                                    "African",
                                    "Arabian",
                                    "Chinese",
                                    "Filipino",
                                    "French",
                                    "Greek",
                                    "Indian",
                                    "Italian",
                                    "Japanese",
                                    "Korean",
                                    "Mediterranean",
                                    "Mexican",
                                    "Middle Eastern",
                                    "Thai",
                                    "Vietnamese"
                                    ]
    var americanMealOptions =  ["-",
                                "Traditional American",
                                "New American",
                                "Barbeque",
                                "Breakfast & Brunch",
                                "Burgers",
                                "Chicken Wings",
                                "Diners",
                                "Fish & Chips",
                                "Pizza",
                                "Salad",
                                "Sandwiches",
                                "Soup",
                                "Steakhouses",
                                "Poke"
                                ]
    var dessertsAndSnacksMealOptions = ["-",
                                        "Cafes",
                                        "Creperies",
                                        "Fondue",
                                        "Acai Bowls",
                                        "Bagels",
                                        "Bakeries",
                                        "Bubble Tea",
                                        "Coffee & Tea",
                                        "Tea Rooms",
                                        "Desserts",
                                        "Donuts",
                                        "Gelato",
                                        "Ice Cream & Frozen Yogurt",
                                        "Juice Bars & Smoothies"
                                        ]
    var otherMealOptions = ["-",
                            "Bistros",
                            "Cafes",
                            "Fondue",
                            "Ramen",
                            "Kebab",
                            "Noodles",
                            "Pizza",
                            "Salad",
                            "Sandwiches",
                            "Seafood",
                            "Soup",
                            "Sushi Bars",
                            "Vegan",
                            "Vegetarian",
                            "Bubble Tea",
                            "Coffee & Tea",
                            "Tea Rooms",
                            "Juice Bars & Smoothies",
                            "Poke"
                    ]
    
    var nightlifeOptions =  ["-",
                             "Beach Bars",
                             "Beer Bar",
                             "Champagne Bars",
                             "Cigar Bars",
                             "Hookah Bars",
                             "Speakeasies",
                             "Sports Bars",
                             "Wine Bars",
                             "Comedy Clubs",
                             "Dance Clubs",
                             "Karaoke",
                             "Piano Bars",
                             "Pool Halls",
                             ]
    
    var priceLevels = ["-",
                       "$",
                       "$$",
                       "$$$",
                       "$$$$"
                       ]
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        //sanitise user selection
        guard firstInterestPicked != "-" || secondInterestPicked != "-" else
        { return }
        guard priceLevelPicked != "-" else
        { return }
        guard currDate != nil else
        { return }
        
        //create new date item object
        if firstInterestPicked != "-" && secondInterestPicked != "-"{
            var newDateItem = DateItem(firstCategory: firstInterestPicked, secondCategory: secondInterestPicked, priceLevel: priceLevelPicked)
            currDate?.dateItemsArray.append(newDateItem)
        }
        else if firstInterestPicked != "-"{
            var newDateItem = DateItem(firstCategory: firstInterestPicked, secondCategory: nil, priceLevel: priceLevelPicked)
            currDate?.dateItemsArray.append(newDateItem)
        }
        else{  //if secondInterestPicked != "-"
            var newDateItem = DateItem(firstCategory: secondInterestPicked, secondCategory: nil, priceLevel: priceLevelPicked)
            currDate?.dateItemsArray.append(newDateItem)
        }
        
        //check if you need to perform segue to API call or unwind
        if currDate?.dateItemsArray.count == currDate?.mainCategories.count{
            //perform sendDetailsToAPI segue
            performSegue(withIdentifier: "sendDetailsToAPI", sender: self)
        }
        else{
            //unwind to unwindToChooseCategory
            performSegue(withIdentifier: "unwindToChooseCategory", sender: self)
        }
    }
    //picker view related data and functions
    // Tag 4 is First Interest Picker
    // Tag 5 is Second Interest Picker
    // Tag 6 is Price Level Picker
    var firstInterestPicked = ""
    var secondInterestPicked = ""
    var priceLevelPicked = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 4 || pickerView.tag == 5{
            return interestArray.count
        }
        else if pickerView.tag == 6{
            return priceLevels.count
        }
        else{
            fatalError("Error in picker")
        }
    }
    
    //determine title for currently displayed component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 4 || pickerView.tag == 5{
            return interestArray[row]
        }
        else if pickerView.tag == 6{
            return priceLevels[row]
        }
        else{
            fatalError("Error in picker")
        }
    }
    
    //respond to user selecting a new row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 4{
            firstInterestPicked = interestArray[row]
        }
        else if pickerView.tag == 5{
            secondInterestPicked = interestArray[row]
        }
        else if pickerView.tag == 6{
            priceLevelPicked = priceLevels[row]
        }
        else{
            fatalError("Error in picker")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard currDate != nil else {
            fatalError("Didnt recieve currDate at SetDetailsViewController")
        }
        print("loaded SetDetailsViewController")
        mainCategoryLabel.text = currDate?.mainCategories[(currDate?.dateItemsArray.count)!]

        // Do any additional setup after loading the view.
        self.firstInterestPicker.dataSource = self;
        self.firstInterestPicker.delegate = self;
        self.secondInterestPicker.dataSource = self;
        self.secondInterestPicker.delegate = self;
        self.pricePicker.dataSource = self;
        self.pricePicker.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sendDetailsToAPI" {
            guard currDate != nil else {
                fatalError("no currDate avaliable at SetDetailsViewController to pass to APICallViewController")
            }
            let apiCallViewController = segue.destination as! APICallViewController
            apiCallViewController.currDate = currDate
        }
    }

}
