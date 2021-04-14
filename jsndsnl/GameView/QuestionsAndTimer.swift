//
//  QuestionsAndTimer.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 11.04.2021.
//

import SwiftUI

struct QuestionsAndTimer: View {
    @ObservedObject var checkAnswer: UserSettings

    var body: some View {
        VStack {
            Text("\(checkAnswer.question)")
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
//                            .scaledToFit()
                .frame(width: 340, height: 170, alignment: .center)
            if checkAnswer.rightImage == true {
                Image("right")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8.0)
                    .frame(width: 160, height: 40, alignment: .center)
            } else {
                Text("Время: \(String(format: "%.2f", checkAnswer.timerPlay))")
                    .font(.body)
                    .foregroundColor(checkAnswer.timerColor)
                    .modifier(buttonMod(width: 150, height: 40))
            }
        }
    }
}
