//
//  Tweet.swift
//  tweets
//
//  Created by Кирилл Комаровский on 16.05.2021.
//

import Foundation

struct Tweet: CustomStringConvertible {
    
    let name: String
    let text: String
    let data: String
    
    var description: String {
        return ("name: \(name), text: \(text), data: \(data)")
    }
}
