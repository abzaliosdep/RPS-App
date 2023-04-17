//
//  MultiPlayerView.swift
//  RPS App
//
//  Created by АБЗАЛ АБЗАЛ on 15.04.2023.
//

import SwiftUI

struct MultiPlayerView: View {
    @State var scrState: ScreenState = .choose
    @State var selfCh: Choices = .rock
    @State var oponentCh: Choices = .rock
    @State var sWin: Int = 0
    @State var sLose: Int = 0
    @State var round: Int = 1
    
    var body: some View {
        switch scrState {
        case .choose:
            Choose(selfCh: $selfCh, scrState: $scrState, sWin: $sWin, sLose: $sLose, round: $round)
        case .change:
            ChangeChoice(choiceC: $selfCh, scrState: $scrState, sWin: $sWin, sLose: $sLose)
        case .openentChoose:
            OpenentWait(oponentCh: $oponentCh, scrState: $scrState)
        case .showOponent:
            OpenentChoice(oponentCh: $oponentCh, choiceC: $selfCh, scrState: $scrState, sWin: $sWin, sLose: $sLose, round: $round)
        }
    }
}

struct Choose: View {
    @Environment(\.presentationMode) var presentationMode
    @State var hideTwoChoices = false
    @Binding var selfCh: Choices
    @Binding var scrState: ScreenState
    @Binding var sWin: Int
    @Binding var sLose: Int
    @Binding var round: Int
    
    
    var body: some View {
        VStack {
            Text("Take your pick")
                .font(.system(size: 50, weight: .bold))
                .padding(.horizontal, 16)
            Text("Player 1 • Score \(sWin):\(sLose)")
                .fontWeight(.medium)
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                .padding(.top, -20)
                .padding(.bottom, 50)
            VStack(spacing: 24) {
                RoundedEmojiButton(emoji: "🧻")
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            selfCh = .paper
                            scrState = .change
                        }
                    }.animation(.easeInOut(duration: 1.0))
                RoundedEmojiButton(emoji: "✂️")
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            selfCh = .scissors
                            scrState = .change
                        }
                    }.animation(.easeInOut(duration: 1.0))
                RoundedEmojiButton(emoji: "🗿")
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            selfCh = .rock
                            scrState = .change
                        }
                    }.animation(.easeInOut(duration: 1.0))
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
        .navigationBarTitle(Text("Round #\(round)"))
    }
}

struct ChangeChoice: View {
    @Binding var choiceC: Choices
    @Binding var scrState: ScreenState
    @Environment(\.presentationMode) var presentationMode
    @Binding var sWin: Int
    @Binding var sLose: Int
    
    var body: some View {
        VStack {
            Text("Your pick")
                .font(.system(size: 54, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.top, 30)
            Text("Player 1 • Score \(sWin):\(sLose)")
                .fontWeight(.medium)
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                .padding(.top, -25)
            Spacer()
            choiceC.emoji
                .padding(.horizontal, 8)
                .onTapGesture {
                    scrState = .openentChoose
                }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 50)
                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                Text("I changed my mind")
                    .onTapGesture {
                        scrState = .choose
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

struct OpenentWait: View {
    @Binding var oponentCh: Choices
    @Binding var scrState: ScreenState
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Pass the phone to your opponent")
            .font(.system(size: 54, weight: .bold))
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .padding(.horizontal, 16)
            .padding(.top, 20)
        Spacer()
        Button(action: {
            scrState = .showOponent
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 50)
                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                Text("Ready to continue")
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
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

struct OpenentChoice: View {
    @Binding var oponentCh: Choices
    @Binding var choiceC: Choices
    @Binding var scrState: ScreenState
    @Environment(\.presentationMode) var presentationMode
    @State var isAct = false
    @State var selectedButton: Int? = nil
    @Binding var sWin: Int
    @Binding var sLose: Int
    @Binding var round: Int
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: FourthView(scrState: $scrState, choiceC: $choiceC, oponentCh: $oponentCh, sWin: $sWin, sLose: $sLose, round: $round),isActive: $isAct) {
                VStack {
                    Text("Your pick")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                    Text("Player 2 • Score \(sWin):\(sLose)")
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                        .padding(.top, -20)
                        .padding(.bottom, 50)
                    VStack(spacing: 24) {
                        RoundedEmojiButton(emoji: "🧻")
                            .opacity(selectedButton == 2 || selectedButton == 3 ? 0 : 1)
                            .onTapGesture {
                                selectedButton = 1
                                oponentCh = .paper
                                isAct = true
                            }
                        RoundedEmojiButton(emoji: "✂️")
                            .opacity(selectedButton == 1 || selectedButton == 3 ? 0 : 1)
                            .onTapGesture {
                                selectedButton = 2
                                oponentCh = .scissors
                                isAct = true
                            }
                        RoundedEmojiButton(emoji: "🗿")
                            .opacity(selectedButton == 2 || selectedButton == 1 ? 0 : 1)
                            .onTapGesture {
                                selectedButton = 3
                                oponentCh = .rock
                                isAct = true
                            }
                    }
                    .padding(.horizontal, 16)
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

struct FourthView: View {
    @Binding var scrState: ScreenState
    @Binding var choiceC: Choices
    @Binding var oponentCh: Choices
    @State private var currentRes = ""
    @Binding var sWin: Int
    @Binding var sLose: Int
    @Binding var round: Int
    
    var body: some View {
        VStack {
            Text("\(getResult())")
                .font(.system(size: 54, weight: .bold))
                .foregroundColor(Color(red: 0.71, green: 0.93, blue: 0.61))
                .padding(.top, 50)
            Text("Score \(sWin):\(sLose)")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
            Spacer()
            ZStack {
                choiceC.emoji
                    .padding(.trailing, 100)
                    .padding(.bottom, 120)
                ZStack {
                    Capsule().fill(.white)
                        .frame(height: 140)
                        .padding(.leading, 100)
                        .padding(.top, 100)
                        .padding(.horizontal, 16)
                    oponentCh.emoji
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
                        round += 1
                        scrState = .choose
                    }
            }
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
    }
    func getResult() -> String {
        var result = ""
        if (choiceC.emoji.isEqual(oponentCh.emoji)) {
            result = "Tie"
        } else if choiceC.emoji.isEqual(RoundedEmojiButton(emoji: "✂️")) && oponentCh.emoji.isEqual(RoundedEmojiButton(emoji: "🧻")) || choiceC.emoji.isEqual(RoundedEmojiButton(emoji: "🧻")) && oponentCh.emoji.isEqual(RoundedEmojiButton(emoji: "🗿")) || choiceC.emoji.isEqual(RoundedEmojiButton(emoji: "🗿")) && oponentCh.emoji.isEqual(RoundedEmojiButton(emoji: "✂️")) {
            DispatchQueue.main.async {
                if currentRes != result {
                    currentRes = result
                    sWin += 1
                }
            }
            result = "Win"
        } else {
            DispatchQueue.main.async {
                if currentRes != result {
                    currentRes = result
                    sLose += 1
                }
            }
            result = "Lose"
        }
        return result
    }
}

struct MultiPlayerView_Previews: PreviewProvider {
    
    static var previews: some View {
        MultiPlayerView()
    }
}
