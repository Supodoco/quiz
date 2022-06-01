//
//  MusicAndHowToPlaying.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 11.04.2021.
//

import SwiftUI

struct MusicOffAndRules: View {
    @ObservedObject var checkAnswer: BrainGameController
    let rules = "Наберите число, которое ближе к правильному ответу. Кто будет ближе к правильному ответу получает +1 балл. Правильный ответ +2 балла."
    @State var alertVersion = false

    var body: some View {
        HStack {
            Button(action: {
                checkAnswer.musicOff.toggle()
            }) {
                if checkAnswer.musicOff == false {
                    Image(systemName: "music.note")
                } else {
                    ZStack {
                        Image(systemName: "music.note")
                        Image(systemName: "line.diagonal")
                            .foregroundColor(.red)
                            .rotationEffect(.degrees(-90))
                    }
                }
            } .modifier(buttonMod(width: 50, height: 50))
            
            Spacer()

            Text("""
                   Версия: \(UserDefaults.standard.integer(forKey: "version"))
                 Вопросов: \(checkAnswer.data89.count)
                 """)
                    .bold()
                    .font(.footnote)
                    .offset(x: 0, y: -25)
                    .onTapGesture {
                        alertVersion.toggle()
                    }
                    .alert(isPresented: $alertVersion, content: {
                      Alert(title: Text("Проверить обновление?"),
                            primaryButton: .default(Text("Проверить"), action: {
                           checkAnswer.checkVersionData(url: checkAnswer.urlVersionData)
                      }),
                              secondaryButton: .default(Text("Назад")))
                      })
            
            Spacer()
            
            Button(action: {
                checkAnswer.alertHowToPlay = true
            }) {
                Image(systemName: "questionmark")
            } .modifier(buttonMod(width: 50, height: 50))
              .alert(isPresented: $checkAnswer.alertHowToPlay, content: {
                 Alert(title: Text("Как играть?"),
                       message: Text(rules),
                       dismissButton: .default(Text("OK")))
            })
        }
    }
}
