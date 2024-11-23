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
        NavigationView {
            VStack {
                GraphView(scores: scores)
                    .frame(height: 200)
                
                List(scores) { score in
                    VStack(alignment: .leading) {
                        Text(dateFormatter.string(from: score.date))
                            .font(.headline)
                        
                        if let uiImage = UIImage(data: score.image) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                        }
                        Text("\(score.score)円")
                            .font(.subheadline)
                            .padding(5)
                            .background(score.score >= 0 ? Color.yellow : Color.blue)
                            .cornerRadius(5)
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
