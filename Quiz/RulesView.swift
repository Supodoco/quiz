//
//  RulesView.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 04.04.2021.
//

import SwiftUI

//struct Rules: View {
//    @Binding var alertActivate: Bool
//    @ObservedObject var checkAnswer = UserSettings()
//
//
//
//    var body: some View {
//        HStack {
//            Button(action: {
//                checkAnswer.cancelPlay = true
//            }, label: {
//                Image(systemName: "arrow.backward.square")
//            }) .modifier(buttonMod(width: 50, height: 50))
//            .padding(.leading)
//            Spacer()
//            Button(action: {
//                self.alertActivate = true
//                
//            }) {
//                Image(systemName: "questionmark")
//            } .modifier(buttonMod(width: 50, height: 50))
//            .padding(.trailing)
//            .alert(isPresented: $alertActivate, content: {
//                Alert(title: Text("Как играть?"), message: Text("Наберите число, которое ближе к правильному ответу. Кто будет ближе к правильному ответу получает +1 балл. Правильный ответ +2 балла."), dismissButton: .default(Text("OK")))
//            })
//        }
//    }
//}
