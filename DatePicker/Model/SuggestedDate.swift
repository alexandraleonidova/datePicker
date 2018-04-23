//
//  suggestedDate.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/21/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import Foundation

struct SuggestedDate{
    var firstDateItemSuggestions: [YelpBusiness]
    var secondDateItemSuggestions: [YelpBusiness]?
    var thirdDateItemSuggestions: [YelpBusiness]?
    
    var firstCategory: String
    var secondCategory: String?
    var thirdCategoty: String?
    
    var firstDateItemSuggestionSet: Bool{
        return firstDateItemSuggestions != nil
    }
    
    var secondDateItemSuggestionSet: Bool{
        return secondDateItemSuggestions != nil
    }
    
    var thirdDateItemSuggestionSet: Bool{
        return thirdDateItemSuggestions != nil
    }
    var numSuggestedDates: Int {
        var count = 0
        if firstDateItemSuggestionSet{
            count += 1
        }
        if secondDateItemSuggestionSet{
            count += 1
        }
        if thirdDateItemSuggestionSet{
            count += 1
        }
        return count
    }
}

