//
//  APICallViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit

class APICallViewController: UIViewController {
    
    var currDate: myDate?
    var currSuggestedDate: SuggestedDate?

    @IBAction func printStatus(_ sender: UIButton) {
        print("********")
        print("********")
        print("********")

        print(currSuggestedDate)
        print("********")
        print(currSuggestedDate)
        
        print("********")
        print("********")
        print("********")


    }
    let categoriesDictionary =     ["Airsoft" : "airsoft",
                                    "Archery" : "archery",
                                    "Amusement Parks" : "amusementparks",
                                    "Aquariums" : "aquariums",
                                    "Batting Cages" : "battingcages",
                                    "Beaches" : "beaches",
                                    "Bowling" : "bowling",
                                    "Bungee Jumping" : "bungeejumping",
                                    "Carousels" : "carousels",
                                    "Climbing": "climbing",
                                    "Escape Games" : "escapegames",
                                    "Flyboarding" : "flyboarding",
                                    "Gokarts" : "gokarts",
                                    "Hiking" : "hiking",
                                    "Horseback Riding" : "horsebackriding",
                                    "Hot Air Balloons" : "hot_air_balloons",
                                    "Jet Skis" : "jetskis",
                                    "Lasertag" : "lasertag",
                                    "Mini Golf" : "mini_golf",
                                    "Paddleboarding" : "paddleboarding",
                                    "Paintball" : "paintball",
                                    "Parks" : "parks",
                                    "Rock Climbing" : "rock_climbing",
                                    "Skating Rinks" : "skatingrinks",
                                    "Skydiving" : "skydiving",
                                    "Trampoline" : "trampoline",
                                    "Waterparks" : "waterparks",
                                    "Zipline" : "zipline",
                                    "Zoos" : "zoos",
                                    "Zorbing" : "zorbing",
                                    "Art Galleries" : "galleries",
                                    "Jazz & Blues" : "jazzandblues",
                                    "Museums" : "museums",
                                    "Art Museums" : "artmuseums",
                                    "Paint & Sip" : "paintandsip",
                                    "Arcades" : "arcades",
                                    "Botanical Gardens" : "gardens",
                                    "Movie Theaters" : "movietheaters",
                                    "Attraction Farms" : "attractionfarms",
                                    "Psychics" : "psychics",
                                    "Wine Tasting Room" : "winetastingroom",
                                    "Dinner Theater" : "dinnertheater",
                                    "Day Spas" : "spas",
                                    "Hot Springs" : "hotsprings",
                                    "Massage" : "massage",
                                    "African" : "african",
                                    "Arabian" : "arabian",
                                    "Chinese" : "chinese",
                                    "Filipino" : "filipino",
                                    "French" : "french",
                                    "Greek" : "greek",
                                    "Indian" : "indpak",
                                    "Italian" : "italian",
                                    "Japanese" : "japanese",
                                    "Korean" : "korean",
                                    "Mediterranean" : "mediterranean",
                                    "Mexican" : "mexican",
                                    "Middle Eastern" : "mideastern",
                                    "Thai" : "thai",
                                    "Vietnamese" : "vietnamese",
                                    "Traditional American" : "tradamerican",
                                    "New American" : "newamerican",
                                    "Barbeque" : "bbq",
                                    "Breakfast & Brunch" : "breakfast_brunch",
                                    "Burgers" : "burgers",
                                    "Chicken Wings" : "chicken_wings",
                                    "Diners" : "diners",
                                    "Fish & Chips" : "fishnchips",
                                    "Pizza" : "pizza",
                                    "Salad" : "salad",
                                    "Sandwiches" : "sandwiches",
                                    "Soup" : "soup",
                                    "Steakhouses" : "steak",
                                    "Poke" : "poke",
                                    "Cafes" : "cafes",
                                    "Creperies" : "creperies",
                                    "Fondue" : "fondue",
                                    "Acai Bowls" : "acaibowls",
                                    "Bagels" : "bagels",
                                    "Bakeries" : "bakeries",
                                    "Bubble Tea" : "bubbletea",
                                    "Coffee & Tea" : "coffee",
                                    "Tea Rooms" : "tea",
                                    "Desserts" : "desserts",
                                    "Donuts" : "donuts",
                                    "Gelato" : "gelato",
                                    "Ice Cream & Frozen Yogurt" : "icecream",
                                    "Juice Bars & Smoothies" : "juicebars",
                                    "Bistros" : "bistros",
                                    "Ramen" : "ramen",
                                    "Kebab" : "kebab",
                                    "Noodles" : "noodles",
                                    "Seafood" : "seafood",
                                    "Sushi Bars" : "sushi",
                                    "Vegan" : "vegan",
                                    "Vegetarian" : "vegetarian",
                                    "Beach Bars" : "beachbars",
                                    "Beer Bar" : "beerbar",
                                    "Champagne Bars" : "champagne_bars",
                                    "Cigar Bars" : "cigarbars",
                                    "Hookah Bars" : "hookah_bars",
                                    "Speakeasies" : "speakeasies",
                                    "Sports Bars" : "sportsbars",
                                    "Wine Bars" : "wine_bar",
                                    "Comedy Clubs" : "comedyclubs",
                                    "Dance Clubs" : "danceclubs",
                                    "Karaoke" : "karaoke",
                                    "Piano Bars" : "pianobars",
                                    "Pool Halls" : "poolhalls"
                                    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        guard currDate != nil else {
            fatalError("APICallViewController did not recieve myDate object")
        }

        gatherBusinessesData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * This function does all nesessary API calls to get data from Yelp about requested date items
     */
    func gatherBusinessesData(){
        var mainPosCount = 0
        for dateItem in currDate!.dateItemsArray{
            if !callAPI(currDateItem: dateItem, mainPos: mainPosCount, subPos: 0, allCityFlag: false){
                sleep(1)
                if !callAPI(currDateItem: dateItem, mainPos: mainPosCount, subPos: 1, allCityFlag: false){
                    sleep(1)
                    if !callAPI(currDateItem: dateItem, mainPos: mainPosCount, subPos: 0, allCityFlag: true){
                        sleep(1)
                        var lastCall = callAPI(currDateItem: dateItem, mainPos: mainPosCount, subPos: 1, allCityFlag: true)
                    }
                }
            }
            mainPosCount += 1
        }
        sleep(3)
        performSegue(withIdentifier: "APIDoneSegue", sender: self)
    }
    
    /* This function performs Yelp API call based on given DateItem
     *
     * @param currDateItem - current date item
     * @param mainPos - position of the date item in the dade (1, 2, 3)
     * @param subPos - first or second choice for given category (1, 2)
     * @param allCityFlag - tru if search needs to be wider, false otherwise
     *
     * @return true if API call was successful, false otherwise
     */
    func callAPI(currDateItem: DateItem, mainPos: Int, subPos: Int, allCityFlag: Bool) -> Bool
    {
        var successFlag = false
        let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search?")!
        
        let headers = [
            "Authorization": "Bearer gq0y48r08GhHAUGx06Y0jLHvWN8CQEEoorM9TAO3ZfBa-pHC8OklpwXUiFrqzgkx33zbHlqDkAP9eIMzpPeim7_Xu2bBukVAYaUXMKWdpiL_RpLvgVRPcSqFcxOmWnYx"
            ]
        
        var query: [String: String] = [:]
        
        if !allCityFlag{
                query["radius"] = "5000"
                query["price"] = String(currDateItem.priceLevelInt)
        }
      
        //set either geolocation or address
        if (currDate?.geoLocationSet)!{
            query["latitude"] = String(describing: currDate!.lattitude)
            query["longitude"] = String(describing: currDate!.longtitude)
        } else {
            query["location"] = currDate?.address
        }
        
        //set category
        if subPos == 1{
            query["categories"] = categoriesDictionary[currDateItem.firstCategory]!
        } else {
            if let category = categoriesDictionary[currDateItem.secondCategory!]{
                query["categories"] = category
            }
        }
        
        let url = baseURL.withQueries(query)!
        let request = url.withHeaders(headers)!
        var retrievedBusinesses: [YelpBusiness] = []
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data{
                if let string = String(data: data, encoding: .utf8) {
                    print(string)
                }
                let tojson = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                if tojson!["error"] == nil{
                    retrievedBusinesses = self.retrieveBusinessDataFromAPI(apiResponse: (tojson!["businesses"] ?? nil)!)
                }
                if retrievedBusinesses.count > 0{
                    successFlag = true
                    switch mainPos{
                        case 0:
                            self.currSuggestedDate = SuggestedDate(firstDateItemSuggestions: retrievedBusinesses, secondDateItemSuggestions: nil, thirdDateItemSuggestions: nil, firstCategory: self.currDate!.mainCategories[0], secondCategory: nil, thirdCategoty: nil)
                        case 1:
                            if self.currSuggestedDate == nil{
                                self.currSuggestedDate = SuggestedDate(firstDateItemSuggestions: retrievedBusinesses, secondDateItemSuggestions: nil, thirdDateItemSuggestions: nil, firstCategory: self.currDate!.mainCategories[1], secondCategory: nil, thirdCategoty: nil)
                            } else {
                                self.currSuggestedDate!.secondDateItemSuggestions = retrievedBusinesses
                                self.currSuggestedDate!.secondCategory = self.currDate!.mainCategories[1]
                                
                            }
                        case 2:
                            if self.currSuggestedDate == nil{
                                self.currSuggestedDate = SuggestedDate(firstDateItemSuggestions: retrievedBusinesses, secondDateItemSuggestions: nil, thirdDateItemSuggestions: nil, firstCategory: self.currDate!.mainCategories[2], secondCategory: nil, thirdCategoty: nil)
                            } else {
                                if self.currSuggestedDate!.secondDateItemSuggestionSet{
                                    self.currSuggestedDate?.thirdDateItemSuggestions = retrievedBusinesses
                                    self.currSuggestedDate!.thirdCategoty = self.currDate!.mainCategories[2]
                                } else {
                                    self.currSuggestedDate?.secondDateItemSuggestions = retrievedBusinesses
                                    self.currSuggestedDate!.secondCategory = self.currDate!.mainCategories[2]
                                }
                            }
                        default:
                            print("Obtained wrong subcategory position")
                        }
                }
            } else {
                print("Either no data was returned, or data was not serialized.")
                if let string = String(data: data!, encoding: .utf8) {
                    print(string)
                }
            }
        }
        task.resume()
        return successFlag
    }
    
    /*
     * This function takes businesses array from API response and converts it into array of YelrBusiness objects
     * @param apiResponse - businesses array from API response
     * @return businesses - array of YelrBusiness obtained from apiResponse
     */
    func retrieveBusinessDataFromAPI(apiResponse: AnyObject) -> [YelpBusiness]{
        print(apiResponse)
        var businesses: [YelpBusiness] = []
        let results = apiResponse as! [AnyObject]
        for result in results {
            let id = result["id"] as! String
            let name = result["name"] as! String
            let image_url = result["image_url"] as! String
            let url = result["url"] as! String
            let rating = (result["rating"] as? Double)!
            var latitude: Double = 0
            var longitude: Double = 0
            if let coordinates = result["coordinates"] as? [String: Any]{
                latitude = (coordinates["latitude"] as? Double)!
                longitude = (coordinates["longitude"] as? Double)!
            }
            let price = result["price"] as? String ?? ""
            var display_address: [String] = []
            if let addressData = result["location"] as? [String: Any]{
                if let addresses = addressData["display_address"]{
                    display_address = (addresses as? [String])!
                }
            }
            let display_phone = result["display_phone"] as! String
            let distance = (result["distance"] as? Double)!
            
            let newBusiness = YelpBusiness(id: id, name: name, image_url: image_url, url: url, rating: rating, latitude: latitude, longitude: longitude, price: price, display_address: display_address, display_phone: display_phone, distance: distance)
            
            businesses.append(newBusiness)
        }
        return businesses
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "APIDoneSegue" {
            let destinationNavigationController = segue.destination
            let optionsTableViewController = destinationNavigationController.childViewControllers[0] as! OptionsTableViewController
            optionsTableViewController.currDate = currDate
            optionsTableViewController.currSuggestedDate = currSuggestedDate
        }
    }

}
