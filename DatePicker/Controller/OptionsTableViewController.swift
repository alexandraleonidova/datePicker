//
//  OptionsTableViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    
    @IBOutlet weak var shortestLabel1: UILabel!
    @IBOutlet weak var shortestLabel2: UILabel!
    @IBOutlet weak var shortestLabel3: UILabel!
    
    @IBOutlet weak var shortestButton: UIButton!
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstLabel1: UILabel!
    @IBOutlet weak var firstLabel2: UILabel!
    @IBOutlet weak var firstLabel3: UILabel!
    
    @IBOutlet weak var firstButton1: UIButton!
    @IBOutlet weak var firstButton2: UIButton!
    @IBOutlet weak var firstButton3: UIButton!
    
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondLabel1: UILabel!
    @IBOutlet weak var secondLabel2: UILabel!
    @IBOutlet weak var secondLabel3: UILabel!
    
    @IBOutlet weak var secondButton1: UIButton!
    @IBOutlet weak var secondButton2: UIButton!
    @IBOutlet weak var secondButton3: UIButton!
    
    @IBOutlet weak var thirdTitleLabel: UILabel!
    @IBOutlet weak var thirdLabel1: UILabel!
    @IBOutlet weak var thirdLabel2: UILabel!
    @IBOutlet weak var thirdLabel3: UILabel!
    
    @IBOutlet weak var thirdButton1: UIButton!
    @IBOutlet weak var thirdButton2: UIButton!
    @IBOutlet weak var thirdButton3: UIButton!
    
    
    var currDate: myDate?
    var currSuggestedDate: SuggestedDate?
    var pickedDate: [YelpBusiness]?
    var pickedFirstItem: YelpBusiness?
    var pickedSecondItem: YelpBusiness?
    var pickedThirdItem: YelpBusiness?
    
    var noThirdItem: Bool = false
    var noSecondItem: Bool = false
    
    var numOfFirstSuggestions: Int = 3
    var numOfSecondSuggestions: Int = 3
    var numOfThirdSuggestions: Int = 3
    
    var shortestDate: SuggestedDate?
    var topSuggestedDate: SuggestedDate?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard currDate != nil, currSuggestedDate != nil else {
            print("no currDate or currSuggestedDate recieved at OptionsTableViewController")
            return
        }
        
        if currSuggestedDate!.secondCategory == nil {
            noSecondItem = true
        }
        if currSuggestedDate!.thirdCategory == nil {
            noThirdItem = true
        }
        //find the date with the shortest distance
        shortestDate = findShortestDistance(currSuggestedDate: currSuggestedDate!)
        
        //populate top suggestions
        topSuggestedDate = findTopItemSuggestions(currSuggestedDate: currSuggestedDate!)
        
        numOfFirstSuggestions = topSuggestedDate!.firstDateItemSuggestions.count
        if let number2 = topSuggestedDate!.secondDateItemSuggestions?.count {
            numOfSecondSuggestions = number2
        } else {
            numOfSecondSuggestions = 0
        }
        if let number3 = topSuggestedDate!.thirdDateItemSuggestions?.count {
            numOfThirdSuggestions = number3
        } else {
            numOfThirdSuggestions = 0
        }
        
        loadTopSuggestions(topSuggestedDate: topSuggestedDate!)
        loadShortestDate(shortestDate: shortestDate!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if noSecondItem && noThirdItem {
            return 2
        } else if noThirdItem {
            return 3
        }
        
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0://shortest distance
            if noSecondItem && noThirdItem {
                return 2
            } else if noThirdItem {
                return 3
            }
            return 4
        case 1: //first item
            return numOfFirstSuggestions + 1
        case 2: //second item
            return numOfSecondSuggestions + 1
        case 3: //third item
            return numOfThirdSuggestions + 1
        default:
            return 4
        }
    }
    
    @IBAction func shortestButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        
        firstButton1.isSelected = false
        firstButton2.isSelected = false
        firstButton3.isSelected = false
        secondButton1.isSelected = false
        secondButton2.isSelected = false
        secondButton3.isSelected = false
        thirdButton1.isSelected = false
        thirdButton2.isSelected = false
        thirdButton3.isSelected = false
        
        pickedFirstItem = shortestDate!.firstDateItemSuggestions[0]
        if !noSecondItem && !noThirdItem {
            pickedSecondItem = shortestDate!.secondDateItemSuggestions![0]
            pickedThirdItem = shortestDate!.thirdDateItemSuggestions![0]
        } else if !noSecondItem {
            pickedSecondItem = shortestDate!.secondDateItemSuggestions![0]
        }
    }
    
    
    @IBAction func firstButtonTapped(_ sender: UIButton) {
        let firstButtons: [UIButton] = [firstButton1, firstButton2, firstButton3]
        
        sender.isSelected = true
        for button in firstButtons {
            if button != sender {
                button.isSelected = false
            }
        }
        
        shortestButton.isSelected = false
        
        switch sender {
        case firstButton1:
            pickedFirstItem = topSuggestedDate!.firstDateItemSuggestions[0]
        case firstButton2:
            pickedFirstItem = topSuggestedDate!.firstDateItemSuggestions[1]
        case firstButton3:
            pickedFirstItem = topSuggestedDate!.firstDateItemSuggestions[2]
        default:
            break
        }
    }
    
    
    @IBAction func secondButtonTapped(_ sender: UIButton) {
        let secondButtons: [UIButton] = [secondButton1, secondButton2, secondButton3]
        
        sender.isSelected = true
        for button in secondButtons {
            if button != sender {
                button.isSelected = false
            }
        }
        
        shortestButton.isSelected = false
        
        switch sender {
        case secondButton1:
            pickedSecondItem = topSuggestedDate!.secondDateItemSuggestions![0]
        case secondButton2:
            pickedSecondItem = topSuggestedDate!.secondDateItemSuggestions![1]
        case secondButton3:
            pickedSecondItem = topSuggestedDate!.secondDateItemSuggestions![2]
        default:
            break
        }
    }
    
    
    @IBAction func thirdButtonTapped(_ sender: UIButton) {
        let thirdButtons: [UIButton] = [thirdButton1, thirdButton2, thirdButton3]
        
        sender.isSelected = true
        for button in thirdButtons {
            if button != sender {
                button.isSelected = false
            }
        }
        
        shortestButton.isSelected = false
        
        switch sender {
        case thirdButton1:
            pickedThirdItem = topSuggestedDate!.thirdDateItemSuggestions![0]
        case thirdButton2:
            pickedThirdItem = topSuggestedDate!.thirdDateItemSuggestions![1]
        case thirdButton3:
            pickedThirdItem = topSuggestedDate!.thirdDateItemSuggestions![2]
        default:
            break
        }
    }
    
    func findShortestDistance(currSuggestedDate: SuggestedDate) -> SuggestedDate {
        var shortestDate = SuggestedDate(firstDateItemSuggestions: [], secondDateItemSuggestions: [], thirdDateItemSuggestions: [], firstCategory: currSuggestedDate.firstCategory, secondCategory: currSuggestedDate.secondCategory, thirdCategory: currSuggestedDate.thirdCategory)
        
        var minDistance: Double = Double.infinity
        var firstDateItemIndex: Int = -1
        var secondDateItemIndex: Int = -1
        var thirdDateItemIndex: Int = -1
        
        if noSecondItem && noThirdItem {
            var i: Int = 0
            for date in currSuggestedDate.firstDateItemSuggestions {
                if date.distance < minDistance {
                    minDistance = date.distance
                    firstDateItemIndex = i
                }
                i += 1
            }
            shortestDate.firstDateItemSuggestions.append(currSuggestedDate.firstDateItemSuggestions[firstDateItemIndex])
        } else if noThirdItem {
            var i: Int = 0
            for dateItem1 in currSuggestedDate.firstDateItemSuggestions {
                var k: Int = 0
                for dateItem2 in currSuggestedDate.secondDateItemSuggestions! {
                    let distance: Double = dateItem1.distance + calculateDistanceBetweenLocations(startLocationLatitude: dateItem1.latitude, startLocationLongitude: dateItem1.longitude, nextLocationLatitude: dateItem2.latitude, nextLocationLongitude: dateItem2.longitude)
                    if distance < minDistance {
                        minDistance = distance
                        firstDateItemIndex = i
                        secondDateItemIndex = k
                    }
                    k += 1
                }
                i += 1
            }
            shortestDate.firstDateItemSuggestions.append(currSuggestedDate.firstDateItemSuggestions[firstDateItemIndex])
            shortestDate.secondDateItemSuggestions = [(currSuggestedDate.secondDateItemSuggestions![secondDateItemIndex])]
        } else {
            var i: Int = 0
            for dateItem1 in currSuggestedDate.firstDateItemSuggestions {
                var k: Int = 0
                for dateItem2 in currSuggestedDate.secondDateItemSuggestions! {
                    var j: Int = 0
                    for dateItem3 in currSuggestedDate.thirdDateItemSuggestions! {
                        let distance: Double = dateItem1.distance + calculateDistanceBetweenLocations(startLocationLatitude: dateItem1.latitude, startLocationLongitude: dateItem1.longitude, nextLocationLatitude: dateItem2.latitude, nextLocationLongitude: dateItem2.longitude) + calculateDistanceBetweenLocations(startLocationLatitude: dateItem2.latitude, startLocationLongitude: dateItem2.longitude, nextLocationLatitude: dateItem3.latitude, nextLocationLongitude: dateItem3.longitude)
                        if distance < minDistance {
                            minDistance = distance
                            firstDateItemIndex = i
                            secondDateItemIndex = k
                            thirdDateItemIndex = j
                        }
                        j += 1
                    }
                    k += 1
                }
                i += 1
            }
            shortestDate.firstDateItemSuggestions.append(currSuggestedDate.firstDateItemSuggestions[firstDateItemIndex])
            shortestDate.secondDateItemSuggestions = [(currSuggestedDate.secondDateItemSuggestions![secondDateItemIndex])]
            shortestDate.thirdDateItemSuggestions = [(currSuggestedDate.thirdDateItemSuggestions![thirdDateItemIndex])]
        }
        
        return shortestDate
    }
    
    func calculateDistanceBetweenLocations(startLocationLatitude: Double, startLocationLongitude: Double, nextLocationLatitude: Double, nextLocationLongitude: Double) -> Double {
        let radius: Double = 3959.0
        
        let deltaLatitude: Double = (degreesToRadians(nextLocationLatitude) - degreesToRadians(startLocationLatitude))
        let deltaLongitude: Double = (degreesToRadians(nextLocationLongitude) - degreesToRadians(startLocationLongitude))
        
        let a: Double = sin(deltaLatitude/2) * sin(deltaLatitude/2) + cos(startLocationLatitude) * cos(nextLocationLatitude) * sin(deltaLongitude/2) * sin(deltaLongitude/2)
        let c: Double = 2 * atan2(sqrt(a), sqrt(1-a))
        
        let distance: Double = radius * c
        
        return distance
    }
    func degreesToRadians(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func findTopItemSuggestions(currSuggestedDate: SuggestedDate) -> SuggestedDate{
        var topSuggestedDate = SuggestedDate(firstDateItemSuggestions: Array(currSuggestedDate.firstDateItemSuggestions.prefix(3)), secondDateItemSuggestions: [], thirdDateItemSuggestions: [], firstCategory: currSuggestedDate.firstCategory, secondCategory: currSuggestedDate.secondCategory, thirdCategory: currSuggestedDate.thirdCategory)
        
        if let secondDateItemArray = currSuggestedDate.secondDateItemSuggestions {
            topSuggestedDate.secondDateItemSuggestions = Array(secondDateItemArray.prefix(3))
        }
        if let thirdDateItemArray = currSuggestedDate.thirdDateItemSuggestions {
            topSuggestedDate.thirdDateItemSuggestions = Array(thirdDateItemArray.prefix(3))
        }
        
        return topSuggestedDate
    }
    
    func loadTopSuggestions(topSuggestedDate: SuggestedDate) {
        //load title of first item
        if numOfFirstSuggestions > 0 { firstTitleLabel.text = topSuggestedDate.firstCategory
        } else {
            firstTitleLabel.text = "\(topSuggestedDate.firstCategory): Could not find any locations"
        }
        if let secondTitle = topSuggestedDate.secondCategory {
            if numOfSecondSuggestions > 0 {
                secondTitleLabel.text = secondTitle
            } else {
                secondTitleLabel.text = "\(secondTitle): Could not find any locations"
            }
        }
        if let thirdTitle = topSuggestedDate.thirdCategory {
            if numOfThirdSuggestions > 0 {
                thirdTitleLabel.text = thirdTitle
            } else {
                thirdTitleLabel.text = "\(thirdTitle): Could not find any locations"
            }
        }
        var i = 1
        for place in topSuggestedDate.firstDateItemSuggestions{
            if i == 1{
                firstLabel1.text = topSuggestedDate.firstDateItemSuggestions[i-1].name
            } else if i == 2 {
                firstLabel2.text = topSuggestedDate.firstDateItemSuggestions[i-1].name
            } else {
                firstLabel3.text = topSuggestedDate.firstDateItemSuggestions[i-1].name
            }
            i += 1
        }
        
        i = 1
        for place in topSuggestedDate.secondDateItemSuggestions!{
            if i == 1{
                secondLabel1.text = topSuggestedDate.secondDateItemSuggestions![i-1].name
            } else if i == 2 {
                secondLabel2.text = topSuggestedDate.secondDateItemSuggestions![i-1].name
            } else {
                secondLabel3.text = topSuggestedDate.secondDateItemSuggestions![i-1].name
            }
            i += 1
        }
        
        i = 1
        for place in topSuggestedDate.thirdDateItemSuggestions!{
            if i == 1{
                thirdLabel1.text = topSuggestedDate.thirdDateItemSuggestions![i-1].name
            } else if i == 2 {
                thirdLabel2.text = topSuggestedDate.thirdDateItemSuggestions![i-1].name
            } else {
                thirdLabel3.text = topSuggestedDate.thirdDateItemSuggestions![i-1].name
            }
            i += 1
        }
    }
    
    func loadShortestDate(shortestDate: SuggestedDate) {
        //load shortest distance date data
        if shortestDate.firstDateItemSuggestions.isEmpty {
            shortestLabel1.text = "\(shortestDate.firstCategory): Could not find any locations"
        } else {
            shortestLabel1.text = shortestDate.firstDateItemSuggestions[0].name
        }
        
        if !noSecondItem && !noThirdItem { //all three date items
            if shortestDate.secondDateItemSuggestions!.isEmpty {
                shortestLabel2.text = "\(shortestDate.secondCategory!): Could not find any locations"
            } else {
                shortestLabel2.text = shortestDate.secondDateItemSuggestions![0].name
            }
            if shortestDate.thirdDateItemSuggestions!.isEmpty {
                shortestLabel3.text = "\(shortestDate.thirdCategory!): Could not find any locations"
            } else {
                shortestLabel3.text = shortestDate.thirdDateItemSuggestions![0].name
            }
        } else if !noSecondItem { //only two date items
            if shortestDate.secondDateItemSuggestions!.isEmpty {
                shortestLabel2.text = "\(shortestDate.secondCategory!): Could not find any locations"
            } else {
                shortestLabel2.text = shortestDate.secondDateItemSuggestions![0].name
            }
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "doneSegue" {
            if let pickedFirstItem = pickedFirstItem{
                pickedDate = [pickedFirstItem]
            }
            if let pickedSecondItem = pickedSecondItem{
                pickedDate!.append(pickedSecondItem)
            }
            if let pickedThirdItem = pickedThirdItem{
                pickedDate!.append(pickedThirdItem)
            }
            
            let dateDetailsController = segue.destination as! DateDetailsTableViewController
            dateDetailsController.pickedDate = pickedDate
        }
    }
    

}
