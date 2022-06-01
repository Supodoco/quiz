//
//  GameSettings.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 11.04.2021.
//

import SwiftUI

struct GameSettings: View {
    
    @ObservedObject var checkAnswer: BrainGameController

    var body: some View {
        
        VStack(spacing: 10) {
            
            Button("Играть") {
                checkAnswer.playerView = false
                if checkAnswer.selectedMode == 0 {
                    checkAnswer.play()
                } else if checkAnswer.selectedMode == 1 {
                    checkAnswer.playDouble()
                }
            } .modifier(buttonMod(width: 260, height: 70))
            Text("Количество игроков")
               
            VStack {
                Picker(selection: $checkAnswer.selectedMode, label: Text("Выберите режим")) {
                    ForEach(0..<checkAnswer.modes.count) { index in
                        Text(self.checkAnswer.modes[index])
                            .background(Color.red)
                    }
                } .pickerStyle(SegmentedPickerStyle())
                .modifier(buttonMod(width: 260, height: 50))
                HStack{
                    Spacer(minLength: 55)
                    VStack{
                        TextField("Имя игрока", text: $checkAnswer.playerOneName) .modifier(buttonMod(width: 260, height: 50))
                        
                        if checkAnswer.selectedMode == 1 {
                            TextField("Имя игрока", text: $checkAnswer.playerTwoName) .modifier(buttonMod(width: 260, height: 50))
                        } else {
                            Text("Бот")
                                .frame(width: 230, height: 50, alignment: .leading)
                                .modifier(buttonMod(width: 260, height: 50))
                        }
                    } .frame(minWidth: 270)
                    if checkAnswer.selectedMode == 0 {
                        Spacer(minLength: 58)
                    } else {
                        Button(action: {
                            checkAnswer.replaceNames()
                        }) {
                            Image(systemName: "arrow.up.arrow.down")
                                .modifier(buttonMod(width: 50, height: 50))
                                
                        }
                    }
                    
                }
                
//                                Spacer()
            } .frame(width: 200, height: 170, alignment: .center)
            

            
            Text("Время на вопрос")
                .alert(isPresented: $checkAnswer.finishPlay, content: {
                    Alert(title: Text("\(checkAnswer.result())"), message: Text("\(checkAnswer.resultTextAlert())"), dismissButton: .default(Text("OK")) )
                })
            
            Stepper("\(Int(checkAnswer.timePerQuestion)) сек", value: $checkAnswer.timePerQuestion, in: 1...30)
                .modifier(buttonMod(width: 260, height: 50))
            
            Text("Количество вопросов")

            Stepper("\(Int(checkAnswer.numberOfQuestions))", value: $checkAnswer.numberOfQuestions, in: 1...10)
                .modifier(buttonMod(width: 260, height: 50))
            
            Text("Последний счёт")
            
            Button("Подробнее") {
                checkAnswer.detailsScore = true
            } .font(.title)
            .modifier(buttonMod(width: 260, height: 50))
            .actionSheet(isPresented: $checkAnswer.detailsScore) {
                ActionSheet(title: Text("\(checkAnswer.detailsScoreText.count == 8 ? "Пока что тут ничего нет" : "Результат последней игры")"), message: Text("\(checkAnswer.textWinWin()) \(checkAnswer.detailsScoreText)"), buttons: [ .default(Text("OK"))])
            }
        }
    }
}
