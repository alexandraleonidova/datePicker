//
//  YelpAPIController.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/20/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

/*
import Foundation

struct YelpAPIController{
    
    func searchBusinesses(completion: @escaping (PhotoInfo?) -> Void)
    {
        let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search?")!
        
        let query: [String: String] = [
            "Authorization": "Bearer gq0y48r08GhHAUGx06Y0jLHvWN8CQEEoorM9TAO3ZfBa-pHC8OklpwXUiFrqzgkx33zbHlqDkAP9eIMzpPeim7_Xu2bBukVAYaUXMKWdpiL_RpLvgVRPcSqFcxOmWnYx"
            ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                print("Either no data was returned, or data was not serialized.")
                if let string = String(data: data!, encoding: .utf8) {
                    print(string)
                    
                }
                print(response)
                completion(nil)
            }
        }
        task.resume()
    }
}
 */
