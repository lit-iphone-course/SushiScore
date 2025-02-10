//
//  ContentView.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2024/11/22.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Score.date, order: .reverse) var scores: [Score]
    @State private var showNewScoreView = false
    
    var body: some View {
        VStack {
            List {
                GraphView(scores: scores)
                    .frame(height: 200)
                ForEach(scores) { score in
                    VStack {
                        Text(dateFormatter.string(from: score.date))
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(score.score)円")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 30)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(score.score >= 0 ? Color.yellow : Color.blue)
                            .cornerRadius(10)
                        
                        if let uiImage = UIImage(data: score.image) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            Spacer()
            
            Button {
                showNewScoreView.toggle()
            } label: {
                Text("新規点数記録")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showNewScoreView) {
                NewScoreView()
            }
        }
        .navigationTitle("記録一覧")
    }
}

#Preview {
    let scores = [
        Score(score: 300, date: Date(), image: Data()),
        Score(score: -150, date: Date().addingTimeInterval(-86400), image: Data()),
        Score(score: 500, date: Date().addingTimeInterval(-172800), image: Data())
    ]
    ContentView()
        .modelContainer(for: [Score.self])
}
