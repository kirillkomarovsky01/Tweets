//
//  APITwitterDelegate.swift
//  tweets
//
//  Created by Кирилл Комаровский on 16.05.2021.
//

import Foundation

protocol APITwitterDelegate: class {
    
    func takeTweets(tweets: [Tweet])
    
    func error(_ error: [NSError])
}
