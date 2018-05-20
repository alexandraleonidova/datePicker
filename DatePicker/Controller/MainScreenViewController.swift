//
//  MainScreenViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova and Taylor Coury on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit
import CoreLocation

class MainScreenViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var mainScrollView: UIScrollView!
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
                if let locValue: CLLocationCoordinate2D = locationManager.location!.coordinate{
                    lattitude = String(locValue.latitude)
                    longtitute = String(locValue.longitude)
                }
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
    var lattitude: String = ""
    var longtitute: String = ""
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        //reset geolocation button
        useCurrentLocationButton.isSelected = false
        let image = UIImage(named: "Unchecked")
        useCurrentLocationButton.setBackgroundImage(image, for: .normal)
        enterAddressStack.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.delegate = self
        registerForKeyboardNotifications()
        
        self.firstSelectionPicker.dataSource = self;
        self.firstSelectionPicker.delegate = self;
        self.secondSelectionPicker.dataSource = self;
        self.secondSelectionPicker.delegate = self;
        self.thirdSelectionPicker.dataSource = self;
        self.thirdSelectionPicker.delegate = self;
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWasShown(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillBeHidden(_:)), name: .UIKeyboardWillHide, object: nil)

    }
    
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
            let keyboardFrameValue =
            info[UIKeyboardFrameBeginUserInfoKey] as? NSValue
            else { return }

        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size

        let contentInsets = UIEdgeInsetsMake(0.0, 0.0,
                                             keyboardSize.height, 0.0)
        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
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
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToMainScreen(unwindSegue: UIStoryboardSegue) {
        firstSelectionPicker.selectRow(0, inComponent: 0, animated: true)
        secondSelectionPicker.selectRow(0, inComponent: 0, animated: true)
        thirdSelectionPicker.selectRow(0, inComponent: 0, animated: true)
        locationPermitted = false
        geoCoordinatesSet = false
        lattitude = ""
        longtitute = ""
        
        //picker view related data and functions
        // Tag 1 is First Picker
        // Tag 2 is Secon Picker
        // Tag 3 is Third Picker
        firstMainCategoryPicked = ""
        secondMainCategoryPicked = ""
        thirdMainCategoryPicked = ""

    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
            
            let currDate = myDate(mainCategories: mainCategoriesArray, subCategories: [], dateItemsArray: [], geoLocationSet: useCurrentLocationButton.isSelected, lattitude: lattitude, longtitude: longtitute, address: addressTextField.text)
            
            chooseCategoryViewController.currDate = currDate
        }
    }
    

}
