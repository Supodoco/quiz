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
                    } catch {}
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
//        UserDefaults.standard.set(self.listQue, forKey: "ListShowQue")
//        print(listQue1)
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
//                self.timerProgressView()
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
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { xr12 in
            self.timerPlay -= 0.2
            if self.timerPlay <= 2.0 {
                self.timerColor = Color.red
            } else if self.timerPlay > 2.0 {
                self.timerColor = Color.black
            }
            if self.timerPlay <= 0.21 {
                self.timerPlay = 0.0
                xr12.invalidate()
            }
        })
        
//        for x in 1...20 * Int(self.timePerQuestion) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 * Double(x), execute: {
//                self.timerPlay -= 0.05
//                if self.timerPlay <= 2.0 {
//                    self.timerColor = Color.red
//                } else if self.timerPlay > 2.0 {
//                    self.timerColor = Color.black
//                }
//                if self.timerPlay <= 0.06 {
//                    self.timerPlay = 0.0
//                }
//            })
//        }
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
    
    @Published var keyList1: Dictionary = [
        
        // Культура
        "Сколько персонажей на картине Тайная вечеря?": 13,
        "Сколько подсолнухов было в третьей версии картины Ван Гога «Подсолнухи»?": 12,
        "Сколько медведей на картине И.И.Шишкина Утро в сосновом лесу?": 4,
        "Сколько персиков на картине В.А.Серова Девочка с персиками?": 3,
        "Сколько бурлаков на картине И.Е.Репина Бурлаки на Волге?": 11,
        "Сколько людей на корабле на картине И.Е.Репина Бурлаки на Волге?": 2,
        "В каком году произошло извержение вулкана Везувия на картине Последний день Помпеи?": 79,
        "Сколько картин входит в самый известный триптих К.С.Малевича?": 3,
        "Сколько коней на картине К.С.Петров-Водкин Купание красного коня?": 3,
        "Сколько в мире яиц Фаберже?": 71,
        
        // Космос
        "Сколько спутников у Земли?": 1,
        "Сколько спутников у Марса?": 2,
        "За какое кол-во земных суток Юпитер совершает полный обророт вокруг своей оси?": 414,
        "Сколько планет в солнечной системе?": 8,
        "Сколько было планет в солнечной системе до 2006 года?": 9,
        "Сколько продолжался полет Ю. Гагарина?": 108,
        "В каком году Юрий Гагарин полетел в космос?": 1961,
        "Какой процент массы солнечной системы приходится на Солнце?": 99,
        "Какова средняя температура поверхности на Венере по Цельсию?": 460,
        "Меркурий какая по счёту планета в солнечной системе?": 1,
        "Сколько масс Земли будет равно массе Плутона?": 454,
        
        // Простые вопросы
        "Сколько букв в слове?": 5,
        "Сколько букв в имени Иосиф Сталин?": 5,
        "Сколько колес у автомобиля?": 4,
        "Сколько суток составляют високосный год?": 366,
        "Сколько цветов в радуге?": 7,
        "Сколько раз в день необходимо чистить зубы?": 2,
        "Сколько согласных в слове Вупсень?": 4,
        "Какого числа отмечают международный день цемента?": 29,
        
        // География
        "Сколько на Земле материков начинаются на букву А?": 5,
        "Какая высота Эвереста в метрах?": 8849,
        "Какая протяжённость у Елисейских полей в метрах?": 1910,
        "Какой мировой рекорд был установлен по погружения в Марианскую впадину в метрах, 28 апреля 2019 года?": 10928,
        
        // Музыка
        "Сколько музыкантов в квинтете?": 5,
        "В каком году «The Beatles» впервые отправились в США?": 1964,
        "В каком году скончался Майкл Джексон?": 2009,
   
        // Биология
        "Сколько глаз у обыкновенной мухи?": 5,
        "Сколько ног у улитки?": 1,
        "Сколько сердец у Осьминога?": 3,
        "Сколько волосков на типичной человеческой голове?": 10000,
        "Сколько вдохов делает человеческое тело ежедневно?": 20000,
//        "Какова продолжительность жизни стрекозы в сутках?": 1,
        "Сколько видов грибов насчитывается в мире в тысячах?": 100,
        "Скольких грамм достигает вес самки перепелятника?": 345,
        "Во сколько раз самка ястреба-перепелятника крупнее самца?": 2,
        "Какой размер в метрах Гигантского кальмара?": 13,
        
        // Литература
        "Сколько раз старик из сказки А. С. Пушкина вызывал Золотую рыбку?": 5,
        "В который час карета и платье золушки превратились обратно в тыкву?": 12,
        "Сколько друзей-гномов у Белоснежки?": 7,
        "Сколько лет Ф.М. Достоевский провел в ссылке?": 10,
        "Какую награду объявили за Карлсона в тысячах крон?": 10,
        
        // Физика
        "Сколько нужно градусов, чтобы вода закипела?": 100,
        "Скорость света в киллометрах в секунду?": 300000,
        "Если вы упали в безвоздушную дыру, проходящую через всю Землю, сколько минут потребуется, чтобы упасть на другую сторону?": 42,
        
        // Кино
        "Сколько друзей было в труппе Трубадура в 'Бременских музыкантах'?": 4,
        "В каком году был выпущен фильм Крестный отец?": 1972,
        "В каком году вышел фильм Король Лев?": 1994,
        "Сколько лет было Дэниэлу Рэдклиффу в фильме Гарри Поттер и Узник Азкабана?": 15,
        "За какое время в секундах перед нами проходят двадцать четыре кадра кинопленки?": 1,
        "В скольких номинациях получил «Оскара» фильм «Титаник»?": 11,
        "В каком году появилась первая система записи звука на кинопленку?": 1912,
        "Сколько стоил молочный коктейль в фильме Криминальное чтиво в центах?": 500,
        "В какой части Карибских пиратов Джек Воробей ограбил банк?": 5,
        "Сколько чертей звал Дартаньян?": 1000,
        "На каком этаже жила главная героиня в фильме Красотка?": 3,
        "Сколько тысяч долларов предложил герой Ричарда Гира героине фильма Красотке за первую неделю услуг?": 3,
        "Сколько детей было у Бенджамина Мартина в фильме Патриот?": 7,
        "Какой день рождения праздновала Шарлотта в ресторане у Уилла Кина в мелодраме Осень в Нью-Йорке?": 22,
       
        // История
        "В каком году отменили крепостное право?": 1861,
        "В каком году было крещение Руси?": 988,
        "Каким по счёту Иваном был Иван Грозный?": 4,
        "В каком году был Карибский кризис?": 1962,
        "В каком году убили Николая Второго?": 1918,
        "Какого числа началась Вторая Мировая Война?": 22,
        "В каком году началась Первая Мировая Война?": 1914,
        "В каком году Чингисхан начинает завоевание Азии?": 1206,
        "Год рождения Будды до нашей эры?": 486,
        "В каком году утонул Титаник во время своего первого плавания из Саутгемптона?": 1912,
        "В каком году изобрели консервную банку?": 1810,
        "Сколько минут длилась Англо-Занзибарская война?":38,
        "Сколько зубов было у лошади Чингизхана?": 2,
        "В каком году было Ледовое побоище?": 1242,
        "В каком году была Куликовская битва?": 1380,
        "Сколько длилась Столетняя война?": 116,
        "Сколько раз прерывалась Столетняя война?": 3,
        "В каком году началась Столетняя война?": 1337,
        "В каком году произошло Стояние на реке Угре?": 1480,
        "Какой по счёту Иван венчался на царство?": 4,
        "В каком году Петр Первый основал Санкт-Петербург?": 1703,
        "В каком году произошло Бородинское сражение?": 1812,
        "В каком году произошло Восстание декабристов?": 1825,
        "В каком году Россия вступила в Первую мировую войну?": 1914,
        "В каком году произошла Октябрьская революция?": 1917,
        "В каком году закончилась Гражданская война в России?": 1920,
        "В каком году запустили первый искусственный спутник Земли?": 1957,
        "В каком году произошла авария на Чернобыльской АЭС?": 1986,
        "В каком году распался СССР?": 1991,
        "В каком веке изобрели зубную пасту?": 4,
        "В каком веке изобрели Шахматы?": 7,
        "В каком году изобрели Прядильную машину?": 1764,
        "В каком году изобрели Газированную воду?": 1767,
        "В каком году появился первый Электродвигатель?": 1834,
        "В каком году придумали розетку?": 1904,

        // Спорт
        "Сколько игроков в олимпийской команде по керлингу?": 4,
        "Сколько игроков в команде по водному поло?": 7,
        "Сколько полей-квадратиков на шахматной доске?": 64,
        "Сколько черных пешек на поле в Шахматах?": 8,
        "Сколько коней на поле в Шахматах?": 4,
        "Сколько игроков в команде в Американском футболе?": 11,
        "В каком году были первые соревнования по Американскому футболу?": 1892,
        
        // Математика
        "Какое число получится при умножении чисел 7 и 8?": 56,
        "Какое число получится при умножении чисел 17 и 5?": 85,
        "Какое число нельзя записать римскими цифрами?": 0,
        "Четные числа делятся на...?": 2,
        "Сколько секунд в 30 минутах?": 1800,
        "На какое число делить нельзя?": 0,
        "Сколько будет 2+2*2?": 6,
        "Сколько сантиметров составляет одна тысячная часть километра?": 100,

        // Факты
        "В каком году запустили YouTube?": 2005,
        "В каком году основали компанию Google?": 1998,
        "В каком году основали компанию Apple?": 1976,
        "Через сколько дней после основания Apple Рональд Уэйн продал свои акции?": 11,
        "В каком году вышел первый Iphone?": 2007
       
    ]
}


