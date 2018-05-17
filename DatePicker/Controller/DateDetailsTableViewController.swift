//
//  DateDetailsTableViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova and Taylor Coury on 4/23/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DateDetailsTableViewController: UITableViewController {
    var pickedDate: [YelpBusiness]?
    var currDate: myDate?
    
    @IBOutlet weak var dateMap: MKMapView!
    @IBOutlet weak var dateMapSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var section1NameLabel: UILabel!
    @IBOutlet weak var section1raitingLabel: UILabel!
    @IBOutlet weak var section1CostLabel: UILabel!
    @IBOutlet weak var section1Address1: UILabel!
    @IBOutlet weak var section1Address2: UILabel!
    @IBOutlet weak var section1LinkButton: UIButton!
    @IBAction func section1LinkButtonTapped(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: pickedDate![0].url)! as URL)
    }
    
    
    @IBOutlet weak var section1imageView: UIImageView!
    
    @IBOutlet weak var section2NameLabel: UILabel!
    @IBOutlet weak var section2raitingLabel: UILabel!
    @IBOutlet weak var section2CostLabel: UILabel!
    @IBOutlet weak var section2Address1: UILabel!
    @IBOutlet weak var section2Address2: UILabel!
    @IBOutlet weak var section2imageView: UIImageView!
    @IBAction func section2LinkButtonTapped(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: pickedDate![1].url)! as URL)
    }
    
    
    @IBOutlet weak var section3NameLabel: UILabel!
    @IBOutlet weak var section3raitingLabel: UILabel!
    @IBOutlet weak var section3CostLabel: UILabel!
    @IBOutlet weak var section3Address1: UILabel!
    @IBOutlet weak var section3Address2: UILabel!
    @IBOutlet weak var section3imageView: UIImageView!
    @IBAction func section3LinkButtonTapped(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: pickedDate![2].url)! as URL)
    }
    
    @IBAction func dateMapSegmentedControlPressed(_ sender: UISegmentedControl) {
        var index: Int
        
        if currDate!.geoLocationSet{
            index = sender.selectedSegmentIndex - 1
        } else {
            index = sender.selectedSegmentIndex
        }
        
        if index < 0{
            index = 0
        }
        
        let initialLocation = CLLocation(latitude: pickedDate![index].latitude,
                                     longitude: pickedDate![index].longitude)
        centerMapOnLocation(location: initialLocation)
    }
    
    func setUpSegmentedControl(){
        guard let pickedDate = pickedDate else { return }
        switch pickedDate.count {
        case 1:
            dateMapSegmentedControl.setTitle(pickedDate[0].name, forSegmentAt: 1)
            dateMapSegmentedControl.removeSegment(at: 2, animated: false)
            dateMapSegmentedControl.removeSegment(at: 3, animated: false)
        case 2:
            dateMapSegmentedControl.setTitle(pickedDate[0].name, forSegmentAt: 1)
            dateMapSegmentedControl.setTitle(pickedDate[1].name, forSegmentAt: 2)
            dateMapSegmentedControl.removeSegment(at: 3, animated: false)
        case 3:
            dateMapSegmentedControl.setTitle(pickedDate[0].name, forSegmentAt: 1)
            dateMapSegmentedControl.setTitle(pickedDate[1].name, forSegmentAt: 2)
            dateMapSegmentedControl.setTitle(pickedDate[2].name, forSegmentAt: 3)
        default:
            return
        }
        
        if currDate!.geoLocationSet{
            dateMapSegmentedControl.setTitle("Start", forSegmentAt: 0)
        } else {
            dateMapSegmentedControl.removeSegment(at: 0, animated: false)
        }
    }
    
    var locationManager = CLLocationManager();
    
    override func viewWillAppear(_ animated: Bool) {

        guard let pickedDate = pickedDate,
            let currDate = currDate
            else { return }
        
        //working with map
        setUpSegmentedControl()
        var initialLocation: CLLocation
        
        if currDate.geoLocationSet{
            initialLocation = CLLocation(latitude: Double(currDate.lattitude)!,
                                         longitude: Double(currDate.longtitude)!)
        } else {
            initialLocation = CLLocation(latitude: pickedDate[0].latitude,
                                         longitude: pickedDate[0].longitude)
        }
        
        centerMapOnLocation(location: initialLocation)
        addAnnotations()

        //working with date details
        setupFirstDateSection()
        if pickedDate.count > 1{
            setupSecondDateSection()
            if pickedDate.count > 2{
                setupThirdDateSection()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return pickedDate!.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numItems = pickedDate!.count

        switch section {
        case 0: //map
            return 2
        case 1: //1st item
            return 5
        case 2: ////2nd item
            if numItems > 1 {
                return 5
            } else {
                return 0
            }
        case 3: //3rd item
            if numItems > 2 {
                return 5
            } else {
                return 0
            }
        default:
            return 0
        }
        
    }

    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        dateMap.setRegion(coordinateRegion, animated: true)
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print("location access denied")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
    
    func addAnnotations(){
        guard let pickedDate = pickedDate,
            let currDate = currDate
            else { return }
        
        var initialLocation: CLLocationCoordinate2D
        var annotations: [MKPointAnnotation] = []
        
        if currDate.geoLocationSet{
            initialLocation = CLLocationCoordinate2D(latitude: Double(currDate.lattitude)!,
                                         longitude: Double(currDate.longtitude)!)
            let initAnnotation = MKPointAnnotation()
            initAnnotation.coordinate = initialLocation
            initAnnotation.title = "Start"
            annotations.append(initAnnotation)
        }
        
        for dateItem in pickedDate{
            var currLocation = CLLocationCoordinate2D(latitude: dateItem.latitude, longitude: dateItem.longitude)
            let currAnnotation = MKPointAnnotation()
            currAnnotation.coordinate = currLocation
            currAnnotation.title = dateItem.name
            currAnnotation.subtitle = dateItem.price
            annotations.append(currAnnotation)
        }
        
        for annotation in annotations{
            dateMap.addAnnotation(annotation)
        }
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func setupFirstDateSection(){
        guard let currPickedDate = pickedDate?[0] else { return }
        section1NameLabel.text = currPickedDate.name
        section1raitingLabel.text = String(currPickedDate.rating)
        section1CostLabel.text = currPickedDate.price
        
        if currPickedDate.display_address.count == 1{
            section1Address1.text = currPickedDate.display_address[0]
            section1Address2.text = ""
        } else if currPickedDate.display_address.count == 2{
            section1Address1.text = currPickedDate.display_address[0]
            section1Address2.text = currPickedDate.display_address[1]
        }
        else {
            section1Address1.text = "\(currPickedDate.display_address[0]), \(currPickedDate.display_address[1])"
            section1Address2.text = currPickedDate.display_address[2]
        }

        if let url = URL(string: currPickedDate.image_url) {
            section1imageView.contentMode = .scaleAspectFill
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.section1imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func setupSecondDateSection(){
        guard let currPickedDate = pickedDate?[1] else { return }
        section2NameLabel.text = currPickedDate.name
        section2raitingLabel.text = String(currPickedDate.rating)
        section2CostLabel.text = currPickedDate.price
        if currPickedDate.display_address.count == 1{
            section2Address1.text = currPickedDate.display_address[0]
            section2Address2.text = ""
        } else if currPickedDate.display_address.count == 2{
            section2Address1.text = currPickedDate.display_address[0]
            section2Address2.text = currPickedDate.display_address[1]
        }
        else {
            section2Address1.text = "\(currPickedDate.display_address[0]), \(currPickedDate.display_address[1])"
            section2Address2.text = currPickedDate.display_address[2]
        }
        if let url = URL(string: currPickedDate.image_url) {
            section2imageView.contentMode = .scaleAspectFill
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.section2imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func setupThirdDateSection(){
        guard let currPickedDate = pickedDate?[2] else { return }
        section3NameLabel.text = currPickedDate.name
        section3raitingLabel.text = String(currPickedDate.rating)
        section3CostLabel.text = currPickedDate.price
        if currPickedDate.display_address.count == 1{
            section3Address1.text = currPickedDate.display_address[0]
            section3Address2.text = ""
        } else if currPickedDate.display_address.count == 2{
            section3Address1.text = currPickedDate.display_address[0]
            section3Address2.text = currPickedDate.display_address[1]
        }
        else {
            section3Address1.text = "\(currPickedDate.display_address[0]), \(currPickedDate.display_address[1])"
            section3Address2.text = currPickedDate.display_address[2]
        }
        if let url = URL(string: currPickedDate.image_url) {
            section3imageView.contentMode = .scaleAspectFill
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.section3imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
