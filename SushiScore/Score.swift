//
//  Score.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2024/11/22.
//

import SwiftData
import Foundation

@Model
class Score: Identifiable {
    var score: Int
    var date: Date
    var image: Data
    
    init(score: Int, date: Date, image: Data) {
        self.score = score
        self.date = date
        self.image = image
    }
}
