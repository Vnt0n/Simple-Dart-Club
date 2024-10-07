//
//  GameViewModel.swift
//  Simple Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import Foundation

struct GameRecord {
    var gameNumber: Int
    var finalScores: [Player]
    var winners: [Player]
}

struct Player {
    var name: String = ""
    var scores: [[Int]] = []
    var remainingScore: Int
    var remainingScoresPerTurn: [Int] = []
    var isBusted: Bool = false
    var lastThrowWasDouble: Bool = false
}

struct Game {
    var players: [Player]
    var gameType: Int
    var currentTurn: Int = 1
    var scoresThisTurn: Int = 0
    var isToggledDoubleOut: Bool = false
}

struct ScoreEntry {
    var score: Int?
    var isModified: Bool
    var isDoubleButtonActivated: Bool = false
    var isTripleButtonActivated: Bool = false
}

class GameViewModel: ObservableObject {
    @Published var currentGame: Game
    @Published var gameStarted: Bool = false
    @Published var gameCount: Int = 1
    @Published var gameHistory: [GameRecord] = []
    @Published var currentPlayerIndex: Int = 0
    @Published var throwScores = Array(repeating: ScoreEntry(score: nil, isModified: false), count: 3)
    @Published var isDouble = [false, false, false]
    @Published var isTriple = [false, false, false]
    @Published var dismissEnterThrowScoreView: Bool = false
    @Published var tempRemainingScore: Int = 0
    @Published var victoryRecorded: Bool = false  // Nouveau drapeau

    
    init(gameType: Int) {
        print("--------------------------------------------")
        print("Init Game")
        let initialPlayer = Player(name: "", scores: [], remainingScore: gameType)
        self.currentGame = Game(players: [initialPlayer], gameType: gameType)
    }

    func addPlayer() {
        print("--------------------------------------------")
        print("addPlayer FUNCTION")
        if currentGame.players.count < 4 {
            currentGame.players.append(Player(name: "", scores: [], remainingScore: currentGame.gameType))
        }
    }

    func removeLastPlayer() {
        print("--------------------------------------------")
        print("removeLastPlayer FUNCTION")
        if currentGame.players.count > 1 {
            currentGame.players.removeLast()
        }
    }

    func addScore(forPlayer index: Int, throwDetails: [(score: Int, isDouble: Bool)]) {
        print("--------------------------------------------")
        print("addScore FUNCTION")
        print("Throw details: \(throwDetails)")
        var player = currentGame.players[index]
        let scores = throwDetails.map { $0.score }
        print("Scores for this turn: \(scores)")
        player.scores.append(scores)

        let scoreTotalForTurn = scores.reduce(0, +)
        print("Total score for this turn: \(scoreTotalForTurn)")
        let lastValidRemainingScore = player.remainingScoresPerTurn.last ?? currentGame.gameType
        print("Last valid remaining score: \(lastValidRemainingScore)")
        let newRemainingScore = lastValidRemainingScore - scoreTotalForTurn
        print("New remaining score: \(newRemainingScore)")

        if newRemainingScore < 0 || (newRemainingScore == 1 && currentGame.isToggledDoubleOut) {
            handleBustForPlayer(&player, lastValidRemainingScore)
            print("Player busted.")
        } else if newRemainingScore == 0 {
            if currentGame.isToggledDoubleOut {
                if checkDoubleOut(throwDetails: throwDetails, newRemainingScore: newRemainingScore) {
                    player.remainingScore = 0
                    player.remainingScoresPerTurn.append(0)
                    player.isBusted = false
                    player.lastThrowWasDouble = true
                    print("Player wins with double out.")
                } else {
                    handleBustForPlayer(&player, lastValidRemainingScore)
                    print("Double out condition not met, player busted.")
                    dismissEnterThrowScoreView = true
                }
            } else {
                player.remainingScore = 0
                player.remainingScoresPerTurn.append(0)
                player.isBusted = false
                print("Player wins without double out.")
            }
        } else {
            player.remainingScore = newRemainingScore
            player.remainingScoresPerTurn.append(newRemainingScore)
            player.isBusted = false
            print("Score updated for player.")
        }

        currentGame.players[index] = player

        currentGame.scoresThisTurn += 1
        if currentGame.scoresThisTurn == currentGame.players.count {
            currentGame.currentTurn += 1
            currentGame.scoresThisTurn = 0
            print("Turn updated to \(currentGame.currentTurn).")
        }
    }

    func checkDoubleOut(throwDetails: [(score: Int, isDouble: Bool)], newRemainingScore: Int) -> Bool {
        print("--------------------------------------------")
        print("checkDoubleOut FUNCTION")
        if newRemainingScore != 0 || !currentGame.isToggledDoubleOut {
            return false
        }
        for (index, detail) in throwDetails.enumerated() {
            if detail.isDouble {
                let subsequentScoresAreZero = throwDetails.dropFirst(index + 1).allSatisfy { $0.score == 0 }
                if subsequentScoresAreZero {
                    return true
                }
            }
        }
        return false
    }

    func handleBustForPlayer(_ player: inout Player, _ lastValidScore: Int) {
        print("--------------------------------------------")
        print("handleBustForPlayer FUNCTION")
        player.remainingScoresPerTurn.append(lastValidScore)
        player.isBusted = true
    }

    func averageThrowScore(forPlayer index: Int) -> Int {
        print("--------------------------------------------")
        print("averageThrowScore FUNCTION")
        let player = currentGame.players[index]
        let totalThrows = player.scores.flatMap { $0 }.count
        if totalThrows > 0 {
            let totalScore = player.scores.flatMap { $0 }.reduce(0, +)
            let averageScore = Double(totalScore) / Double(totalThrows)
            return Int(floor(averageScore))
        } else {
            return 0
        }
    }

    func averageThrowScoreInGame(forPlayer player: Player, gameRecord: GameRecord) -> Int {
        print("--------------------------------------------")
        print("averageThrowScoreInGame FUNCTION")
        let scores = gameRecord.finalScores.first { $0.name == player.name }?.scores.flatMap { $0 } ?? []
        let totalThrows = scores.count
        let totalScore = scores.reduce(0, +)
        return totalThrows > 0 ? Int(floor(Double(totalScore) / Double(totalThrows))) : 0
    }

    func isPlayerBusted(playerIndex: Int) -> Bool {
        print("--------------------------------------------")
        print("isPlayerBusted FUNCTION")
        return currentGame.players[playerIndex].remainingScore < 0
    }

    func endGame() {
        print("--------------------------------------------")
        print("endGame FUNCTION")
        
        if !victoryRecorded {  // Vérifie si la victoire a déjà été enregistrée
            let winners = currentGame.players.filter {
                if currentGame.isToggledDoubleOut {
                    return $0.remainingScore == 0 && $0.lastThrowWasDouble
                } else {
                    return $0.remainingScore == 0
                }
            }

            let record = GameRecord(gameNumber: gameCount, finalScores: currentGame.players, winners: winners)
            gameHistory.append(record)
            
            victoryRecorded = true  // Met à jour le drapeau après enregistrement
        }
        
        resetForNextGame()
    }

    func countVictories() -> [String: Int] {
        print("--------------------------------------------")
        print("countVictories FUNCTION")
        var victories = [String: Int]()
        
        // Ajout de tous les joueurs actuels avec une victoire par défaut à 0
        for player in currentGame.players {
            victories[player.name] = 0
        }

        for record in gameHistory {
            for winner in record.winners {
                victories[winner.name, default: 0] += 1
            }
        }

        return victories
    }

    func resetForNextGame() {
        print("--------------------------------------------")
        print("resetForNextGame FUNCTION")
        gameCount += 1
        for i in 0..<currentGame.players.count {
            currentGame.players[i].remainingScore = currentGame.gameType
            currentGame.players[i].scores.removeAll()
            currentGame.players[i].remainingScoresPerTurn.removeAll()
            currentGame.players[i].isBusted = false
        }
        currentGame.currentTurn = 1
        currentPlayerIndex = (gameCount - 1) % currentGame.players.count
        currentGame.scoresThisTurn = 0
        victoryRecorded = false
    }

    func resetThrowScores() {
        print("--------------------------------------------")
        print("resetThrowScores FUNCTION")
            throwScores = Array(repeating: ScoreEntry(score: nil, isModified: false), count: 3)
            isDouble = [false, false, false]
            isTriple = [false, false, false]
        }

    func submitScores() {
        print("--------------------------------------------")
        print("submitScores FUNCTION")
        let throwDetails = zip(throwScores.compactMap { $0.score }, throwScores.map { $0.isDoubleButtonActivated }).map { (score: $0, isDouble: $1) }
        addScore(forPlayer: currentPlayerIndex, throwDetails: throwDetails)
        currentPlayerIndex = (currentPlayerIndex + 1) % currentGame.players.count
        resetThrowScores()
    }
    
    func checkScoreAfterThrow() {
        print("--------------------------------------------")
        print("checkScoreAfterThrow FUNCTION")
        
        let player = currentGame.players[currentPlayerIndex]
        let validScores = throwScores.compactMap { $0.score }
        let scoresSoFar = validScores.reduce(0, +)
        self.tempRemainingScore = player.remainingScore - scoresSoFar
        
        print("tempRemainingScore = \(tempRemainingScore)")

        if tempRemainingScore == 0 {
            if currentGame.isToggledDoubleOut {

                let currentThrowIsDouble = throwScores.first { $0.isDoubleButtonActivated } != nil
                if currentThrowIsDouble {
                    print("Player wins with Double Out!")
                    submitScores()
                    dismissEnterThrowScoreView = true
                } else {
                    print("Double Out condition not met, continue the game.")
                    submitScores()
                    dismissEnterThrowScoreView = true
                }
            } else {
                print("Player wins without Double Out!")
                submitScores()
                dismissEnterThrowScoreView = true
            }
        }
        
        if tempRemainingScore == 1 && currentGame.isToggledDoubleOut {
            print("Score is 1, dismissing the view.")
            submitScores()
            dismissEnterThrowScoreView = true
        }
        
        if tempRemainingScore < 0 {
            print("Player Busted!")
            submitScores()
            dismissEnterThrowScoreView = true
        }
    }
    
    func resetGame() {
        print("--------------------------------------------")
        print("resetGame FUNCTION")
        
        for i in currentGame.players.indices {
            currentGame.players[i].scores.removeAll()
            currentGame.players[i].remainingScore = currentGame.gameType
            currentGame.players[i].remainingScoresPerTurn.removeAll()
            currentGame.players[i].isBusted = false
            currentGame.players[i].lastThrowWasDouble = false
        }

        currentGame.currentTurn = 1
        currentPlayerIndex = 0
        currentGame.scoresThisTurn = 0
        gameCount = 1
        dismissEnterThrowScoreView = false
        gameHistory.removeAll()
    }
    
    func hasWinningPlayer() -> Bool {
        return currentGame.players.contains { $0.remainingScore == 0 }
    }

}
