//
//  Player.swift
//  DartClub
//
//  Created by Antoine on 27/03/2024.
//

import Foundation
import SwiftData

@Model
class Player {
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
