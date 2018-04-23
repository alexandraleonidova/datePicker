//
//  URL+Helpers.swift
//  DatePicker
//
//  Created by Alexandra Leonidova on 4/20/18.
//  Copyright © 2018 Alexandra Leonidova. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
    
    func withHeaders(_ headers: [String: String]) -> URLRequest? {
        var request = URLRequest(url: self)
        request.httpMethod = "GET"
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
    
    func withHTTPS() -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.scheme = "https"
        return components?.url
    }
}
