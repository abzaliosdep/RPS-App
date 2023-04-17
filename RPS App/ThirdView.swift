//
//  ThirdView.swift
//  RPS App
//
//  Created by АБЗАЛ АБЗАЛ on 14.04.2023.
//

import SwiftUI

struct ThirdView: View {
    @Binding var gameResult: String
    @Binding var oponentChoice: Choices
    
    var body: some View {
        VStack {
            Text("Результат игры: \(gameResult)")
                .font(.system(size: 54, weight: .bold))
                .foregroundColor(Color(red: 0.71, green: 0.93, blue: 0.61))
                .padding(.top, 50)
            Text("Score 0:0")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
            Spacer()
            ZStack {
                RoundedEmojiButton(emoji: "🧻")
                    .padding(.trailing, 100)
                    .padding(.bottom, 100)
                RoundedEmojiButton(emoji: "🗿")
                    .padding(.leading, 100)
                    .padding(.top, 100)
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 50)
                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                Text("Another round")
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
    }
}
