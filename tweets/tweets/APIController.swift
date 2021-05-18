//
//  APIController.swift
//  tweets
//
//  Created by Кирилл Комаровский on 16.05.2021.
//

import Foundation
import UIKit

class APIController{
    
    let token: String
    weak var delegat: APITwitterDelegate?
    
    init(delegat: APITwitterDelegate?, token: String) {
        
        self.delegat = delegat
        self.token = token
    }
    
    func performRequest(string: String) {
        
        let req = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(req)&lang=fr&count=100")
        
        print(url!)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
    }
}
