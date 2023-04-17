//
//  SecondView.swift
//  RPS App
//
//  Created by АБЗАЛ АБЗАЛ on 13.04.2023.
//

import SwiftUI

enum Choices: CaseIterable {
    case paper
    case rock
    case scissors
    
    var emoji: RoundedEmojiButton {
        switch self {
        case .paper:
            return RoundedEmojiButton(emoji: "🧻")
        case .rock:
            return RoundedEmojiButton(emoji: "🗿")
        case .scissors:
            return RoundedEmojiButton(emoji: "✂️")
        }
    }
}

enum ScreenState {
    case choose
    case change
    case openentChoose
    case showOponent
}

struct SinglePlayerView: View {
    @State var screenState: ScreenState = .choose
    @State var selfChoice: Choices = .rock
    @State var oponentChoice: Choices = .rock
    @State var scoreWin: Int = 0
    @State var scoreLose: Int = 0
    @State var rounds: Int = 1
    
    var body: some View {
        switch screenState {
        case .choose:
            ChooseView(selfChoice: $selfChoice, screenState: $screenState, scoreWin: $scoreWin, scoreLose: $scoreLose, rounds: $rounds)
        case .change:
            ChangeChoiceView(choice: $selfChoice, screenState: $screenState, scoreWin: $scoreWin, scoreLose: $scoreLose)
        case .openentChoose:
            OpenentWaitView(oponentChoice: $oponentChoice, screenState: $screenState)
        case .showOponent:
            OpenentChoiceView(choice: $selfChoice, oponentChoice: $oponentChoice, screenState: $screenState, selfChoice: $selfChoice, scoreWin: $scoreWin, scoreLose: $scoreLose, rounds: $rounds)
        }
    }
}

struct ChooseView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selfChoice: Choices
    @Binding var screenState: ScreenState
    @Binding var scoreWin: Int
    @Binding var scoreLose: Int
    @Binding var rounds: Int
    
    var body: some View {
        VStack {
            Text("Take your pick")
                .font(.system(size: 50, weight: .bold))
                .padding(.horizontal, 16)
            Text("Score \(scoreWin):\(scoreLose)")
                .fontWeight(.medium)
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                .padding(.top, -20)
                .padding(.bottom, 50)
            VStack(spacing: 24) {
                RoundedEmojiButton(emoji: "🧻")
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            selfChoice = .paper
                            screenState = .change
                        }
                    }.animation(.easeIn(duration: 1.0))
                RoundedEmojiButton(emoji: "✂️")
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            selfChoice = .scissors
                            screenState = .change
                        }
                    }.animation(.easeIn(duration: 1.0))
                RoundedEmojiButton(emoji: "🗿")
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            selfChoice = .rock
                            screenState = .change
                        }
                    }.animation(.easeIn(duration: 1.0))
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Round #\(rounds)")
    }
}

struct ChangeChoiceView: View {
    @Binding var choice: Choices
    @Binding var screenState: ScreenState
    @Environment(\.presentationMode) var presentationMode
    @Binding var scoreWin: Int
    @Binding var scoreLose: Int
    
    var body: some View {
        VStack {
            Text("Your pick")
                .font(.system(size: 54, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.top, 30)
            Text("Score \(scoreWin):\(scoreLose)")
                .fontWeight(.medium)
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                .padding(.top, -25)
            Spacer()
            choice.emoji
                .padding(.horizontal, 8)
                .onTapGesture {
                    screenState = .openentChoose
                }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 50)
                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                Text("I changed my mind")
                    .onTapGesture {
                        screenState = .choose
                    }
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
        })
    }
}

struct OpenentWaitView: View {
    @Binding var oponentChoice: Choices
    @Binding var screenState: ScreenState
    @Environment(\.presentationMode) var presentationMode
    @State private var isRotating = false
    var choices: [Choices] = [.paper, .rock, .scissors]
    
    var body: some View {
        Text("Your opponent is thinking")
            .font(.system(size: 54, weight: .bold))
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .padding(.horizontal, 16)
            .padding(.top, 20)
        Spacer()
        ZStack {
            Capsule()
                .fill(Color(red: 0.953, green: 0.949, blue: 0.973))
                .frame(height: 128)
            Image("Vector")
                .font(.system(size: 40))
                .rotationEffect(isRotating ? Angle(degrees: 360) : Angle(degrees: 0))
                .onAppear() {
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                        self.isRotating = true
                    }
                }
        }
        .padding(.horizontal, 24)
        Spacer()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    oponentChoice = choices.randomElement() ?? choices[0]
                    screenState = .showOponent
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
            })
    }
}

struct OpenentChoiceView: View {
    @Binding var choice: Choices
    @Binding var oponentChoice: Choices
    @Environment(\.presentationMode) var presentationMode
    @State var isActive = false
    @Binding var screenState: ScreenState
    @Binding var selfChoice: Choices
    @Binding var scoreWin: Int
    @Binding var scoreLose: Int
    @Binding var rounds: Int
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: ThirdView(choice: choice, oponentChoice: oponentChoice, screenState: $screenState, selfChoice: $selfChoice, scoreWin: $scoreWin, scoreLose: $scoreLose, rounds: $rounds), isActive: $isActive) {
                VStack(spacing: 50) {
                    Text("Your opponent`s pick")
                        .font(.system(size: 54, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                    Spacer()
                    randomChoice(oponentChoice)
                    Spacer()
                        .padding(.horizontal, 24)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isActive = true
                            }
                        }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
        })
    }
}

struct RoundedEmojiButton: View {
    let emoji: String
    func isEqual(_ other: RoundedEmojiButton) -> Bool {
        return self.emoji == other.emoji
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color(red: 0.953, green: 0.949, blue: 0.973))
                .frame(height: 128)
            Text(emoji)
                .font(.system(size: 80))
        }
        .padding(.horizontal, 24)
    }
}

func randomChoice(_ choice: Choices) -> RoundedEmojiButton {
    switch choice {
    case .paper:
        return RoundedEmojiButton(emoji: "🧻")
    case .rock:
        return RoundedEmojiButton(emoji: "🗿")
    case .scissors:
        return RoundedEmojiButton(emoji: "✂️")
    }
}

struct ThirdView: View {
    var choice: Choices
    var oponentChoice: Choices
    @Binding var screenState: ScreenState
    @Binding var selfChoice: Choices
    @State private var currentResult = ""
    @Binding var scoreWin: Int
    @Binding var scoreLose: Int
    @Binding var rounds: Int
    
    var body: some View {
        VStack {
            Text("\(getResult())")
                .font(.system(size: 54, weight: .bold))
                .foregroundColor(Color(red: 0.71, green: 0.93, blue: 0.61))
                .padding(.top, 50)
            Text("Score \(scoreWin):\(scoreLose)")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
            Spacer()
            ZStack {
                choice.emoji
                    .padding(.trailing, 100)
                    .padding(.bottom, 120)
                ZStack {
                    Capsule().fill(.white)
                        .frame(height: 140)
                        .padding(.leading, 100)
                        .padding(.top, 100)
                        .padding(.horizontal, 16)
                    randomChoice(oponentChoice)
                        .padding(.leading, 100)
                        .padding(.top, 100)
                }
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 50)
                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                Text("Another round")
                    .foregroundColor(.white)
                    .onTapGesture {
                        rounds += 1
                        screenState = .choose
                    }
            }
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
    }
    
    func getResult() -> String {
        var result = ""
        if (choice.emoji.isEqual(oponentChoice.emoji)) {
            result = "Tie"
        } else if choice.emoji.isEqual(RoundedEmojiButton(emoji: "✂️")) && oponentChoice.emoji.isEqual(RoundedEmojiButton(emoji: "🧻")) || choice.emoji.isEqual(RoundedEmojiButton(emoji: "🧻")) && oponentChoice.emoji.isEqual(RoundedEmojiButton(emoji: "🗿")) || choice.emoji.isEqual(RoundedEmojiButton(emoji: "🗿")) && oponentChoice.emoji.isEqual(RoundedEmojiButton(emoji: "✂️")) {
            DispatchQueue.main.async {
                if currentResult != result {
                    currentResult = result
                    scoreWin += 1
                }
            }
            result = "Win"
        } else {
            DispatchQueue.main.async {
                if currentResult != result {
                    currentResult = result
                    scoreLose += 1
                }
            }
            result = "Lose"
        }
        return result
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerView()
    }
}
