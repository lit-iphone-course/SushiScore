//
//  GraphView.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2024/11/22.
//

import SwiftUI
import Charts

struct GraphView: View {
    var scores: [Score]
    
    var body: some View {
        Chart {
            ForEach(scores) { score in
                LineMark(
                    x: .value("日付", score.date, unit: .day),
                    y: .value("点数", score.score)
                )
                .foregroundStyle(.yellow)
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                if let date = value.as(Date.self) {
                    AxisValueLabel {
                        Text(date.formatted(.dateTime.month().day()))
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel(value.as(Int.self)?.description ?? "")
            }
        }
    }
}

#Preview {
    let scores = [
        Score(score: 300, date: Date(), image: Data()),
        Score(score: -150, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, image: Data()),
        Score(score: 500, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, image: Data())
    ]
    GraphView(scores: scores)
        .frame(height: 300)
        .padding()
}
