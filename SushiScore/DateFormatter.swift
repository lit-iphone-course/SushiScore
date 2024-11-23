//
//  DateFormatter.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2024/11/23.
//

import Foundation

var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter
}
