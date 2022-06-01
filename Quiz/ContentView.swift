//
//  ContentView.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 01.04.2021.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @StateObject private var checkAnswer = BrainGameController()
    @State var alertActivate = false

    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), .blue, Color(#colorLiteral(red: 0.5568627715, green: 0.722259367, blue: 0.9686274529, alpha: 1)), .blue, Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
                VStack(spacing: 10) {
                    
                    if checkAnswer.playerView == true {
                        
                        MusicOffAndRules(checkAnswer: checkAnswer)

                        Spacer()
                        
                        GameSettings(checkAnswer: checkAnswer)
                        
                        Spacer()
                        
                    } else {
                        
                        TableScores(checkAnswer: checkAnswer)
                        
                        Spacer()
                            
                        QuestionsAndTimer(checkAnswer: checkAnswer)
                        
                        KeyboardAndTappedText(checkAnswer: checkAnswer)
                        
                    }
                
            } .padding(.all)
        } .onAppear {
            checkAnswer.checkVersionData(url: checkAnswer.urlVersionData)
        }
        
    }
}
