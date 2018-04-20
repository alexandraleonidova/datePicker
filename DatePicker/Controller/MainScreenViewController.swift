//
//  MainScreenViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit
import CoreLocation

class MainScreenViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var enterAddressStack: UIStackView!
    @IBOutlet weak var firstSelectionPicker: UIPickerView!
    @IBOutlet weak var thirdSelectionPicker: UIPickerView!
    @IBOutlet weak var secondSelectionPicker: UIPickerView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var useCurrentLocationButton: UIButton!
    
    @IBAction func useCurrentLocationButtonPressed(_ sender: UIButton) {
        if !locationPermitted{
            requestLocationAccess()
            locationPermitted = true
        }

        useCurrentLocationButton.isSelected = !useCurrentLocationButton.isSelected
        
        if useCurrentLocationButton.isSelected{
            let image = UIImage(named: "Checked")
            useCurrentLocationButton.setBackgroundImage(image, for: .normal)
            if !geoCoordinatesSet {
                guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
                lattitude = Double(locValue.latitude)
                longtitute = Double(locValue.longitude)
            }
        } else {
            let image = UIImage(named: "Unchecked")
            useCurrentLocationButton.setBackgroundImage(image, for: .normal)
        }
        enterAddressStack.isHidden = !enterAddressStack.isHidden
        
    }
    
    let mainCategories = ["-", "Activity", "Meal", "Nightlife"]
    
    var locationPermitted = false
    var geoCoordinatesSet = false
    var locationManager = CLLocationManager();
    var lattitude: Double?
    var longtitute: Double?
    
    //picker view related data and functions
    // Tag 1 is First Picker
    // Tag 2 is Secon Picker
    // Tag 3 is Third Picker
    var firstMainCategoryPicked = ""
    var secondMainCategoryPicked = ""
    var thirdMainCategoryPicked = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainCategories.count
    }
    
    //determine title for currently displayed component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return mainCategories[row]
    }
    
    //respond to user selecting a new row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            firstMainCategoryPicked = mainCategories[row]
        }
        else if pickerView.tag == 2{
            secondMainCategoryPicked = mainCategories[row]
        }
        else if pickerView.tag == 3{
            thirdMainCategoryPicked = mainCategories[row]
        }
        else{
            print("Error in picker")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.firstSelectionPicker.dataSource = self;
        self.firstSelectionPicker.delegate = self;
        self.secondSelectionPicker.dataSource = self;
        self.secondSelectionPicker.delegate = self;
        self.thirdSelectionPicker.dataSource = self;
        self.thirdSelectionPicker.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print("location access denied")
        default:
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //TODO: move this to block segue if parameters are bad
        /*
        guard firstMainCategoryPicked.count > 1 || secondMainCategoryPicked.count > 1 || thirdMainCategoryPicked.count > 1 else
        { return }
        
        guard useCurrentLocationButton.isSelected || addressTextField.text?.count == 5 else
        { return }
        */
        
        if segue.identifier == "mainScreenSegue" {
            let chooseCategoryViewController = segue.destination as! ChooseCategoryViewController
            
            var mainCategoriesArray: [String] = []
            if firstMainCategoryPicked.count > 1{
                mainCategoriesArray.append(firstMainCategoryPicked)
            }
            if secondMainCategoryPicked.count > 1{
                mainCategoriesArray.append(secondMainCategoryPicked)
            }
            if thirdMainCategoryPicked.count > 1{
                mainCategoriesArray.append(thirdMainCategoryPicked)
            }
            
            //TODO: add address and geolocation when becomes applicable
            let currDate = myDate(mainCategories: mainCategoriesArray, subCategories: [], dateItemsArray: [], geoLocationSet: useCurrentLocationButton.isSelected, lattitude: lattitude, longtitude: longtitute, address: addressTextField.text)
            
            chooseCategoryViewController.currDate = currDate
        }
    }
    

}
