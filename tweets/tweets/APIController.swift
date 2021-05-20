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
        urlRequest.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let task = URLSession.shared
        task.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if let err = error {
                self.delegat?.error((err as NSError) as! [NSError])
            }
            else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                        var twt = [Tweet]()
                        for tweet in (dic["statuses"] as! NSArray) {
                            
                        }
                    }
                }
            }
        })
    }
}
