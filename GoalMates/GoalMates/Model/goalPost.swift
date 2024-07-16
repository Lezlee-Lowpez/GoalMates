//
//  goalPost.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/7/24.
//

import Foundation

struct GoalPost : Codable {
    var name: String
    var goals: [String]

    
    enum CodingKeys: String, CodingKey {
           case name
           case goals
       }
}
