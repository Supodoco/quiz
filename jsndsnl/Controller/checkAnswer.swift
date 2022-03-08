//
//  checkAnswer.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 03.04.2021.
//

import Foundation
import SwiftUI
import AVFoundation



class UserSettings: ObservableObject {
    
    @Published var keyList1: [String : Int] = [
        
        "Сколько персонажей на картине Тайная вечеря?": 13,
        "Сколько спутников у Земли?": 1,
        "Сколько букв в слове?": 5,
        "Сколько на Земле материков начинаются на букву А?": 5,
        "Сколько музыкантов в квинтете?": 5,
        
    ]
    
    var urlData: String = "https://pastebin.com/raw/HXE9N1P0"
    
    func downloadData(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let questions = try JSONDecoder().decode([QuestionsAnswers].self, from: data)
                for element in questions {
                    DispatchQueue.main.async {
                        self.keyList1[element.question] = element.answer
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        } .resume()
    }
    
    @Published var musicOff = false
    @Published var alertHowToPlay = false
    
    @Published var audioPlayer: AVAudioPlayer?
    @Published var detailsScore = false
    @Published var detailsScoreText = "Сыграем?"
    
    @Published var timePerQuestion: Double = 5.0
    @Published var numberOfQuestions = 5

    @Published var numberKeyList = [0,1,2,3,4,5,6,7,8,9]
    @Published var tappedText = ""

    @Published var peopleScore = 0
    @Published var botScore = 0
    @Published var peopleRightAnswerCount = 0
    @Published var botRightAnswerCount = 0

    @Published var question = ""
    @Published var botGenerator = Int.random(in: Range(1...15))
    @Published var answer = 0
    
    @Published var count = 0
    @Published var secondPlus = 0.0
    @Published var playerView = true
    
    @Published var timerPlay = 5.0
    @Published var timerColor = Color.black
    @Published var rightImage = false
    
    @Published var finishPlay = false
    @Published var listQue = [Int]()
    @Published var winWin1 = "\n\n"
    @Published var listQue1 = UserDefaults.standard.array(forKey: "ListShowQue")
    
    @Published var questionsDoubleGame = [String]()
    @Published var answersFirstPlayerDoubleGame = [Int]()
    @Published var rightAnswersDoubleGame = [Int]()
    @Published var selectedMode = 0
    @Published var modes = ["1", "2"]
    @Published var playerOneName = "Кирилл"
    @Published var playerTwoName = "Вика"
    @Published var alertAfterFirstPlay = false

    func textEnd(_ score: Int) -> String {
        switch score {
        case(1): return ""
        case(2...4): return "а"
        default:
            return "ов"
        }
    }
    
    func playSongRightAnswer(_ caser: Int) {
        if musicOff == false {
            var nameOfSong = ""
            switch caser {
            case(1): nameOfSong = "rightAns"
            case(2): nameOfSong = "victory"
            case(3): nameOfSong = "defeat"
            default: break
            }
            for numberOfSong in 1...3 {
                if caser == numberOfSong {
                    let pathToSound = Bundle.main.path(forResource: nameOfSong, ofType: "wav")!
                    let url = URL(fileURLWithPath: pathToSound)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayer?.play()
                    } catch { return }
                }
            }
        }
    }
    
    func textWinWin() -> String {
        if selectedMode == 0 {
            return "\(botScore == 0 && peopleScore == 0 ? "" : "\(result()). \(playerOneName): \(peopleScore) балл\(textEnd(peopleScore)). Бот: \(botScore) балл\(textEnd(botScore)). \(winWin1)")"
        } else {
            return "\(botScore == 0 && peopleScore == 0 ? "" : "\(result()). \(playerOneName): \(peopleScore) балл\(textEnd(peopleScore)). \(playerTwoName): \(botScore) балл\(textEnd(botScore)). \(winWin1)")"
        }
    }
    
    func resultTextAlert() -> String {
        if selectedMode == 0 {
            return """
                \(playerOneName.count != 0 ? playerOneName : "Ваш счёт"): \(peopleScore) из \(numberOfQuestions * 2) балл\(textEnd(peopleScore)).
                Правильных ответов: \(peopleRightAnswerCount) из \(numberOfQuestions).

                Бот счёт: \(botScore) из \(numberOfQuestions * 2) балл\(textEnd(botScore)).
                Правильных ответов: \(botRightAnswerCount) из \(numberOfQuestions).
                """
        } else {
            return """
                \(playerOneName.count != 0 ? playerOneName : "1 игрок"): \(peopleScore) из \(numberOfQuestions * 2) балл\(textEnd(peopleScore)).
                Правильных ответов: \(peopleRightAnswerCount) из \(numberOfQuestions).

                \(playerTwoName.count != 0 ? playerTwoName : "2 игрок"): \(botScore) из \(numberOfQuestions * 2) балл\(textEnd(botScore)).
                Правильных ответов: \(botRightAnswerCount) из \(numberOfQuestions).
                """
        }
        
    }
    func result() -> String {
        if selectedMode == 0 {
            if peopleScore == 0 && botScore == 0 {
                return ""
            }else if peopleScore > botScore {
                return "Вы выиграли"
            } else if peopleScore < botScore {
                return "Вы проиграли"
            } else {
                return "Ничья"
            }
        } else {
            if peopleScore == 0 && botScore == 0 {
                return ""
            }else if peopleScore > botScore {
                return "\(playerOneName) выиграл(а)"
            } else if peopleScore < botScore {
                return "\(playerTwoName) выиграл(а)"
            } else {
                return "Ничья"
            }
        }
    }
    
    func replaceNames() {
        let x = playerOneName
        let y = playerTwoName
        playerOneName = y
        playerTwoName = x
    }
    
    func genQuestionSecond() {
        repeat {
            count = Int.random(in: Range(0...keyList1.count - 1))
        } while listQue.contains(count)
        listQue.append(count)
        var counter = -1
        for (questions, answers) in keyList1 {
            counter += 1
            if count == counter {
                question = questions
                questionsDoubleGame.append(question)
                answer = answers
                rightAnswersDoubleGame.append(answer)
                counter = -1
                break
            }
        }
    }
    
    
    func playDouble() {
        peopleScore = 0 // 1 player
        botScore = 0 // 2 player
        questionsDoubleGame = [] // Список вопросов
        answersFirstPlayerDoubleGame = [] // Список ответов на вопросы первого игрока
        rightAnswersDoubleGame = [] // Список правильных ответов
        secondPlus = 0
        botRightAnswerCount = 0
        peopleRightAnswerCount = 0
        detailsScoreText = ""
        image456 = true
        func rightAnswerNumbersDouble(peopleAnswer: Int, rightAnswer: Int) {
            if peopleAnswer == rightAnswer {
                self.peopleScore += 2
                self.rightImage = true
                self.peopleRightAnswerCount += 1
                playSongRightAnswer(1)
            }
        }
        if (keyList1.count - listQue.count) < numberOfQuestions {
            listQue = []
        }
        for x in 1...self.numberOfQuestions {
            DispatchQueue.main.asyncAfter(deadline: .now() + secondPlus, execute: {
                self.genQuestionSecond()
                self.timer()
            })
            secondPlus += self.timePerQuestion
            DispatchQueue.main.asyncAfter(deadline: .now() + secondPlus, execute: {
                rightAnswerNumbersDouble(peopleAnswer: Int(self.tappedText) ?? 9999999999999999, rightAnswer: self.answer)
                self.answersFirstPlayerDoubleGame.append((Int(self.tappedText) != nil) ? Int(self.tappedText)! : 9999999999999999)
                self.timerColor = Color.black
                self.timerPlay = self.timePerQuestion
                if self.rightImage == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.rightImage = false
                    })
                }
                self.tappedText = ""
                if self.numberOfQuestions == x {
                    self.question = "Ожидание второго игрока"
                    self.alertAfterFirstPlay = true
                    self.image456 = false
                }
            })
        }
    }
    @Published var image456 = false

    func playSecondContinue() {
        func rightAnswerNumbersDouble(peopleAnswer: Int, rightAnswer: Int) {
            if peopleAnswer == rightAnswer {
                self.peopleScore -= 2
                self.peopleRightAnswerCount -= 1
            }
        }
        self.secondPlus = 0
        var nextQuestion = 0
        for x in 1...self.numberOfQuestions {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.secondPlus, execute: {
                self.question = self.questionsDoubleGame[nextQuestion]
                self.answer = self.rightAnswersDoubleGame[nextQuestion]
                self.timer()
                
            })
            self.secondPlus += self.timePerQuestion
            DispatchQueue.main.asyncAfter(deadline: .now() + self.secondPlus, execute: {
                self.timerColor = Color.black
                self.timerPlay = self.timePerQuestion
                rightAnswerNumbersDouble(peopleAnswer: self.answersFirstPlayerDoubleGame[nextQuestion], rightAnswer: self.answer) // Удаляет каунтер += правильных ответов первого игрока
                let y = self.rightAnswerNumbers(botAnswer: Int(self.tappedText) ?? 9999999999999999, peopleAnswer: self.answersFirstPlayerDoubleGame[nextQuestion], rightAnswer: self.answer)
                self.detailsScoreText += self.question + " \(self.playerOneName.count != 0 ? self.playerOneName : "1 игрок"): \(self.answersFirstPlayerDoubleGame[nextQuestion] != 9999999999999999 ? String(self.answersFirstPlayerDoubleGame[nextQuestion]) : "Нет ответа"), \(self.playerTwoName.count != 0 ? self.playerTwoName : "2 игрок"): \(self.tappedText.count != 0 ? self.tappedText : "Нет ответа"). " + y + self.winWin1 // текст последнего счета
                if self.rightImage == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.rightImage = false
                    })
                }
                nextQuestion += 1
                self.tappedText = ""
                if self.numberOfQuestions == x {
                    self.playerView = true
                    self.finishPlay = true
                    if self.peopleScore < self.botScore {
                        self.playSongRightAnswer(2)
                    } else if self.peopleScore > self.botScore {
                        self.playSongRightAnswer(3)
                    }
                }
            })
        }
    }
    
    
    func play() {
        peopleScore = 0
        botScore = 0
        count = 0
        secondPlus = 0
        botRightAnswerCount = 0
        peopleRightAnswerCount = 0
        detailsScoreText = ""
        if (keyList1.count - listQue.count) < numberOfQuestions {
            listQue = []
        }
        for x in 1...self.numberOfQuestions {
            DispatchQueue.main.asyncAfter(deadline: .now() + secondPlus, execute: {
                self.genQuestionSecond()
                self.timer()
            })
            secondPlus += self.timePerQuestion
            DispatchQueue.main.asyncAfter(deadline: .now() + secondPlus, execute: {
                self.cleverBot()
                self.timerColor = Color.black
                self.timerPlay = self.timePerQuestion
                let y = self.rightAnswerNumbers(botAnswer: self.botGenerator, peopleAnswer: Int(self.tappedText) ?? 9999999999999999, rightAnswer: self.answer)
                self.detailsScoreText += self.question + " \(self.playerOneName.count != 0 ? self.playerOneName : "Ваш ответ"): \(self.tappedText.count != 0 ? self.tappedText : "Нет ответа"), Бот: \(self.botGenerator). " + y + self.winWin1
                if self.rightImage == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.rightImage = false
                    })
                }

                self.tappedText = ""
                if self.numberOfQuestions == x {
                    self.playerView = true
                    self.finishPlay = true
                    if self.peopleScore < self.botScore {
                        self.playSongRightAnswer(3)
                    } else if self.peopleScore > self.botScore {
                        self.playSongRightAnswer(2)
                    }
                }
            })
        }
    }
    func cleverBot() {
        
        switch self.answer {
        case(0...10): self.botGenerator = Int.random(in: Range(0...10))
        case(11...50): self.botGenerator = Int.random(in: Range(11...50))
        case(51...100): self.botGenerator = Int.random(in: Range(51...100))
        case(101...500): self.botGenerator = Int.random(in: Range(101...500))
        case(501...1000): self.botGenerator = Int.random(in: Range(501...1000))
        case(1001...1500): self.botGenerator = Int.random(in: Range(1001...1500))
        case(1501...1700): self.botGenerator = Int.random(in: Range(1501...1700))
        case(1701...1800): self.botGenerator = Int.random(in: Range(1701...1800))
        case(1801...1900): self.botGenerator = Int.random(in: Range(1801...1900))
        case(1901...1950): self.botGenerator = Int.random(in: Range(1901...1950))
        case(1951...2000): self.botGenerator = Int.random(in: Range(1951...2000))
        case(2001...2050): self.botGenerator = Int.random(in: Range(2001...2050))
        case(2051...2100): self.botGenerator = Int.random(in: Range(2051...2100))
        case(2101...5000): self.botGenerator = Int.random(in: Range(2101...5000))
        case(5001...10000): self.botGenerator = Int.random(in: Range(5001...10000))
        case(10001...20000): self.botGenerator = Int.random(in: Range(10001...20000))
        case(20001...50000): self.botGenerator = Int.random(in: Range(20001...50000))
        case(50001...100000): self.botGenerator = Int.random(in: Range(50001...100000))
        case(100001...1000000): self.botGenerator = Int.random(in: Range(100001...1000000))
        default:
            self.botGenerator = Int.random(in: Range(1000000...9999999999))
        }
    }
    
    func timer() {
        self.timerPlay = self.timePerQuestion
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { timer in
            self.timerPlay -= 0.2
            if self.timerPlay <= 2.0 {
                self.timerColor = Color.red
            } else if self.timerPlay > 2.0 {
                self.timerColor = Color.black
            }
            if self.timerPlay <= 0.21 {
                self.timerPlay = 0.0
                timer.invalidate()
            }
        })
    }
    
    func rightAnswerNumbers(botAnswer: Int, peopleAnswer: Int, rightAnswer: Int) -> String {
        let x = "Правильный ответ:"
        var botWin = "Бот был ближе к правильному ответу. "
        var peopleWin = "Вы были ближе к правильному ответу. "
        var botRight = "Бот дал точный ответ. "
        var peopleRight = "Вы дали точный ответ. "
        let paritet = "Вы были одинаково близки к ответу. "
        let winWin = "Вы оба ответили правильно. "
        
        if selectedMode == 0 { // человек - бот
            peopleWin = "\(playerOneName) был(а) ближе к правильному ответу. "
            peopleRight = "\(playerOneName) дал(а) точный ответ. "
        } else { // человек - человек
            botWin = "\(playerTwoName) был(а) ближе к правильному ответу. "
            peopleWin = "\(playerOneName) был(а) ближе к правильному ответу. "
            botRight = "\(playerTwoName) дал(а) точный ответ. "
            peopleRight = "\(playerOneName) дал(а) точный ответ. "
        }
        if botAnswer == rightAnswer && peopleAnswer == rightAnswer {
            self.peopleScore += 2
            self.rightImage = true
            self.peopleRightAnswerCount += 1
            self.botRightAnswerCount += 1
            self.botScore += 2
            playSongRightAnswer(1)
            return "\(x) \(rightAnswer). \(winWin)"
        } else if botAnswer == rightAnswer {
            self.botScore += 2
            self.botRightAnswerCount += 1
            if selectedMode == 1 {
                self.rightImage = true
                playSongRightAnswer(1)
            }
            return "\(x) \(rightAnswer). \(botRight)"
        } else if peopleAnswer == rightAnswer {
            self.peopleScore += 2
            if self.selectedMode == 1 && image456 == true {
                self.rightImage = true
                playSongRightAnswer(1)
            } else if selectedMode == 0 {
                self.rightImage = true
                playSongRightAnswer(1)
            }
            self.peopleRightAnswerCount += 1
            return "\(x) \(rightAnswer). \(peopleRight)"
        } else if nearestNumber(right: rightAnswer, custom: botAnswer) < nearestNumber(right: rightAnswer, custom: peopleAnswer) {
            self.botScore += 1
            return "\(x) \(rightAnswer). \(botWin)"
        } else if nearestNumber(right: rightAnswer, custom: peopleAnswer) < nearestNumber(right: rightAnswer, custom: botAnswer) {
            self.peopleScore += 1
            return "\(x) \(rightAnswer). \(peopleWin)"
        } else if nearestNumber(right: rightAnswer, custom: botAnswer) == nearestNumber(right: rightAnswer, custom: peopleAnswer) {
            self.peopleScore += 1
            self.botScore += 1
            return "\(x) \(rightAnswer). \(paritet)"
        } else {
            return "\(x) \(rightAnswer)."
        }
    }

    
    func nearestNumber(right: Int, custom: Int) -> Int {
        var x1: Int
        var x2: Int
        x1 = right - custom
        x2 = custom - right
        if x1 < x2 {
            return x2
        } else {
            return x1
        }
    }
}


