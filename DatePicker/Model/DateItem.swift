//
//  DateItem.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/17/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import Foundation

struct DateItem{
    var category: String
    var categoryKey: String
    
    var priceLevel: Int
    
    var geoLocationSet: Bool
    
    //MAY BE ALL INTS?
    var lattitude: String?
    var longtitude: String?
    var address: String?
}
