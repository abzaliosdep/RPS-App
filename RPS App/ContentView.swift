//
//  ContentView.swift
//  RPS App
//
//  Created by АБЗАЛ АБЗАЛ on 13.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("BackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .background(Color.clear)
                VStack {
                    Text("Welcome to the game!")
                        .font(.system(size: 51, weight: .bold))
                        .foregroundColor(.white)
                        .frame(height: 124)
                        .multilineTextAlignment(.center)
                    Spacer()
                    NavigationLink(destination: SinglePlayerView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(height: 50)
                                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                            Text("Single player")
                                .foregroundColor(.white)
                        }
                    }
                    NavigationLink(destination: MultiPlayerView() ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(height: 50)
                                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                            Text("Multi player")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 60)
                .padding(.top, 100)
                .padding(.horizontal, 16)
                Path { path in
                    path.move(to: CGPoint(x: 130, y: 830))
                    path.addLine(to: CGPoint(x: 260, y: 830))
                }
                .stroke(Color.black, lineWidth: 8)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
