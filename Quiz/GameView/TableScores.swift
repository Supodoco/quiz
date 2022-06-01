//
//  TableScores.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 11.04.2021.
//

import SwiftUI

struct TableScores: View {
    @ObservedObject var checkAnswer: BrainGameController

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image("Human")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .frame(width: 50, height: 50, alignment: .trailing)
                    Spacer()
                    Text("\(checkAnswer.peopleScore)")
                    
                } .modifier(buttonMod(width: 130, height: 80))
                Text(checkAnswer.playerOneName.count == 0 ? "\(checkAnswer.selectedMode == 0 ? "Вы" : "1 игрок")" : "\(checkAnswer.playerOneName)")
                    .font(.footnote)
                    .modifier(buttonMod(width: 130, height: 30))
            }.frame(width: 160, height: 40, alignment: .center)
            
            Spacer()
            VStack{
                HStack {
                    Text("\(checkAnswer.botScore)")
                    Spacer()
                    Image(checkAnswer.selectedMode == 0 ? "Robot" : "HumanReversed")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .frame(width: 50, height: 50, alignment: .trailing)
                } .modifier(buttonMod(width: 130, height: 80))
                
                Text(checkAnswer.selectedMode == 0 ? "Бот" : "\(checkAnswer.playerTwoName.count == 0 ? "2 игрок" : "\(checkAnswer.playerTwoName)")" )
                    .font(.footnote)
                    .modifier(buttonMod(width: 130, height: 30))
            }.frame(width: 160, height: 40, alignment: .center)
        } .padding(.top, 20)
    }
}

