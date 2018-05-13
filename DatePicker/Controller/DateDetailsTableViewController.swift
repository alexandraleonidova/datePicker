//
//  DateDetailsTableViewController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/23/18.
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
    
    @IBAction func dateMapSegmentedControlPressed(_ sender: UISegmentedControl) {
        var index: Int
        
        if currDate!.geoLocationSet{
            index = sender.selectedSegmentIndex - 1
        } else {
            index = sender.selectedSegmentIndex
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
        // #warning Incomplete implementation, return the number of sections
        return pickedDate!.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numItems = pickedDate!.count
        switch section {
        case 0:
            return 5
        case 1:
            if numItems > 1 {
                return 5
            } else {
                return 1
            }
        case 2:
            if numItems > 2 {
                return 5
            } else {
                return 1
            }
        case 3: 
            return 2
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
        print("locations = \(locValue.latitude) \(locValue.longitude)")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
