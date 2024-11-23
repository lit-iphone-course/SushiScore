//
//  NewScoreView.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2024/11/22.
//

import SwiftUI
import PhotosUI
import SwiftData

struct NewScoreView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var scoreText: String = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(dateFormatter.string(from: Date()))
                .font(.title)
            
            TextField("点数を入力", text: $scoreText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            if let selectedImageData {
                let uiImage = UIImage(data: selectedImageData)!
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            
            PhotosPicker(selection: $selectedImage) {
                Text("画像を追加")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .onChange(of: selectedImage) {
                Task {
                    selectedImageData = try? await selectedImage?.loadTransferable(type: Data.self)
                }
            }
            
            Button("保存") {
                Task {
                    await saveRecord()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .alert("全ての項目を入力してください", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    private func saveRecord() async {
        guard let score = Int(scoreText),
              let selectedImage = selectedImage,
              let imageData = try? await selectedImage.loadTransferable(type: Data.self)
        else {
            showAlert = true
            return
        }
        
        let newScore = Score(score: score, date: Date(), image: imageData)
        context.insert(newScore)
        dismiss()
    }
}

#Preview {
    NewScoreView()
        .modelContainer(for: [Score.self])
}
