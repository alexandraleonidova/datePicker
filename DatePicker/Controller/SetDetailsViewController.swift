//
//  SetDetailsViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit

class SetDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var firstInterestPicker: UIPickerView!
    @IBOutlet weak var secondInterestPicker: UIPickerView!
    @IBOutlet weak var pricePicker: UIPickerView!
    
    //this is data from Coose Category Screen
    var recievedSubCategory: String = ""
    var dateItemsArray: [DateItem] = []
    
    //target categories arrays
    //TODO - move it to a model (and create model)
    var activeLifeOptions =     ["Airsoft",
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
    
    var artOptions =    ["Art Galleries",
                        "Jazz & Blues",
                        "Museums",
                        "Art Museums",
                        "Paint & Sip"]
    
    var entertainmentOptions = ["Arcades",
                                "Botanical Gardens",
                                "Movie Theaters",
                                "Attraction Farms",
                                "Psychics",
                                "Wine Tasting Room",
                                "Dinner Theater"
                                ]
    
    var beautyAndSpaOptions =  ["Day Spas",
                                "Hot Springs",
                                "Massage"
                                ]
    
    var internationalMealOptions = ["African",
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
    var americanMealOptions =  ["Traditional American",
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
    var dessertsAndSnacksMealOptions = ["Cafes",
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
    var otherMealOptions = ["Bistros",
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
    
    var nightlifeOptions = ["Beach Bars",
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


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //debug
        print(recievedSubCategory)
        print(dateItemsArray)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
