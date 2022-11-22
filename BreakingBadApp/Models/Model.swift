//
//  Model.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 21.11.2022.
//

import Foundation

struct Character: Decodable {
    
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: String
    let nickname: String
    let portrayed: String
    let category: String
}

