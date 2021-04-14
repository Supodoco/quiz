//
//  SwiftUIView.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 04.04.2021.
//

import SwiftUI

struct buttonMod: ViewModifier {
    @State var width: CGFloat
    @State var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(minWidth: width, maxWidth: width, minHeight: height*0.7, maxHeight: height, alignment: .center)
            .font(.largeTitle)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(15.0)
    }
}

struct KeyboardAndTappedText: View {
    @ObservedObject var checkAnswer: UserSettings
    @State var lister:Array = [1,4,7]

    var body: some View {
        VStack(spacing: 10) {
            
            Text("Наберите число")
                .font(.title3)
            
            Text(self.checkAnswer.tappedText)
                .modifier(buttonMod(width: 260, height: 70))
                .alert(isPresented: $checkAnswer.alertAfterFirstPlay, content: {
                    Alert(title: Text("Ожидание второго игрока"), dismissButton: .default(Text("Продолжить")) {
                        checkAnswer.alertAfterFirstPlay = false
                        checkAnswer.playSecondContinue()
                    })
                })
            
            ForEach(Range(0...2)) { num1 in
                HStack(spacing: 10) {
                    ForEach(Range(lister[num1]...lister[num1]+2)) { num in
                        Button("\(checkAnswer.numberKeyList[num])"){
                            checkAnswer.tappedText = checkAnswer.tappedText + "\(checkAnswer.numberKeyList[num])"
                        } .modifier(buttonMod(width: 80, height: 70))
                    }
                }
            }
            HStack(spacing: 10) {
                Button(action: {
                    if checkAnswer.tappedText.count > 0 {
                        checkAnswer.tappedText = ""
                        print("\(checkAnswer.tappedText) 'кнопка стереть всё'")
                    }
                }) {
                    Image(systemName: "clear")
                } .modifier(buttonMod(width: 80, height: 70))
                
                Button("0"){
                    checkAnswer.tappedText = checkAnswer.tappedText + "\(checkAnswer.numberKeyList[0])"
                    print(checkAnswer.tappedText)
                } .modifier(buttonMod(width: 80, height: 70))
                
                Button(action: {
                    if checkAnswer.tappedText.count > 0 {
                        checkAnswer.tappedText = String(checkAnswer.tappedText.prefix(checkAnswer.tappedText.count - 1))
                        print("\(checkAnswer.tappedText) 'кнопка стереть'")
                    }
                }) {
                    Image(systemName: "delete.left")
                } .modifier(buttonMod(width: 80, height: 70))
            }
        }
    }
}



