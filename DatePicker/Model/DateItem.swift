//
//  DateItem.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import Foundation

struct DateItem{
    var firstCategory: String
    //var firstCategoryKey: String?
    
    var secondCategory: String?
    //var secondCategoryKey: String?
    
    var priceLevel: String
    var priceLevelInt: Int {
        switch priceLevel{
            case "$":
                return 1
            case "$$":
                return 2
            case "$$$":
                return 3
            case "$$$$":
                return 0
            default:
                return -1
        }
    }
    
    //var geoLocationSet: Bool?
    
    //MAY BE ALL INTS?
    //var lattitude: String?
    //var longtitude: String?
    //var address: String?
}
