//
//  GameViewModel.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

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
    var lastThrowWasDouble: Bool = false // Ajout pour suivre si le dernier lancer était un double
}

struct Game {
    var players: [Player]
    var gameType: Int
    var currentTurn: Int = 1
    var scoresThisTurn: Int = 0
    var isToggledDoubleOut: Bool = false
}

class GameViewModel: ObservableObject {
    @Published var currentGame: Game
    @Published var gameStarted: Bool = false
    @Published var gameCount: Int = 1
    @Published var gameHistory: [GameRecord] = []
    @Published var currentPlayerIndex: Int = 0
    
    init(gameType: Int) {
        print("--------------------------------------------")
        print("INIT GAME")
        let initialPlayer = Player(name: "", scores: [], remainingScore: gameType)
        self.currentGame = Game(players: [initialPlayer], gameType: gameType)
    }
    
    func addPlayer() {
        print("--------------------------------------------")
        print("FONCTION ADDPLAYER")
        if currentGame.players.count < 4 {
            currentGame.players.append(Player(name: "", scores: [], remainingScore: currentGame.gameType))
        }
    }
        
    func addScore(forPlayer index: Int, throwDetails: [(score: Int, isDouble: Bool)]) {
        var player = currentGame.players[index]
        let scores = throwDetails.map { $0.score }
        player.scores.append(scores)  // Ajouter toujours le score à l'historique des lancers du joueur

        let scoreTotalForTurn = scores.reduce(0, +)
        let lastValidRemainingScore = player.remainingScoresPerTurn.last ?? currentGame.gameType
        let newRemainingScore = lastValidRemainingScore - scoreTotalForTurn

        if newRemainingScore < 0 {
            // Gérer le cas où le joueur dépasse le score requis (bust)
            handleBustForPlayer(&player, lastValidRemainingScore)
        } else if newRemainingScore == 0 {
            // Gérer le cas où le joueur atteint exactement zéro
            if currentGame.isToggledDoubleOut {
                // Si Double Out est activé, vérifier que le dernier lancer était un double et qu'aucun point n'est marqué après
                if checkDoubleOut(throwDetails: throwDetails, newRemainingScore: newRemainingScore) {
                    player.remainingScore = 0
                    player.remainingScoresPerTurn.append(0)
                    player.isBusted = false
                    player.lastThrowWasDouble = true
                } else {
                    handleBustForPlayer(&player, lastValidRemainingScore)
                }
            } else {
                // Si Double Out n'est pas activé, le joueur gagne dès que son score atteint zéro
                player.remainingScore = 0
                player.remainingScoresPerTurn.append(0)
                player.isBusted = false
            }
        } else {
            // Pour les scores positifs qui ne sont pas exactement zéro
            player.remainingScore = newRemainingScore
            player.remainingScoresPerTurn.append(newRemainingScore)
            player.isBusted = false
        }

        currentGame.players[index] = player
            
            // Gérer l'incrémentation des tours
            currentGame.scoresThisTurn += 1
            if currentGame.scoresThisTurn == currentGame.players.count {
                currentGame.currentTurn += 1
                currentGame.scoresThisTurn = 0
            }
    }
    
    func checkDoubleOut(throwDetails: [(score: Int, isDouble: Bool)], newRemainingScore: Int) -> Bool {
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
        print("Bust! Score remains the same at \(lastValidScore), recording \(lastValidScore) for this turn.")
        player.remainingScoresPerTurn.append(lastValidScore)  // Ajouter le dernier valide à nouveau
        player.isBusted = true
    }

    func averageThrowScore(forPlayer index: Int) -> Int {
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
        let scores = gameRecord.finalScores.first { $0.name == player.name }?.scores.flatMap { $0 } ?? []
        let totalThrows = scores.count
        let totalScore = scores.reduce(0, +)
        return totalThrows > 0 ? Int(floor(Double(totalScore) / Double(totalThrows))) : 0
    }
    
    func isPlayerBusted(playerIndex: Int) -> Bool {
        return currentGame.players[playerIndex].remainingScore < 0
    }

    func endGame() {
        let winners = currentGame.players.filter {
            if currentGame.isToggledDoubleOut {
                return $0.remainingScore == 0 && $0.lastThrowWasDouble
            } else {
                return $0.remainingScore == 0
            }
        }
        let record = GameRecord(gameNumber: gameCount, finalScores: currentGame.players, winners: winners)
        gameHistory.append(record)
        resetForNextGame()
    }

    func countVictories() -> [String: Int] {
            var victories = [String: Int]()

            for record in gameHistory {
                for winner in record.winners {
                    victories[winner.name, default: 0] += 1
                }
            }
            
            return victories
        }

    func resetForNextGame() {
        print("--------------------------------------------")
        print("FONCTION RESETFORNEXTGAME")
        print(" ")
        gameCount += 1  // Incrémenter le compteur de jeu
        for i in 0..<currentGame.players.count {
            currentGame.players[i].remainingScore = currentGame.gameType
            currentGame.players[i].scores.removeAll()
            currentGame.players[i].remainingScoresPerTurn.removeAll()
            currentGame.players[i].isBusted = false
        }
        currentGame.currentTurn = 1
        print("currentPlayerIndex AVANT Formule : \(currentPlayerIndex)")
        print(" ")
        currentPlayerIndex = (gameCount - 1) % currentGame.players.count
        print("currentPlayerIndex APRÈS Formule : \(currentPlayerIndex)")
        print(" ")
        print("currentTurn APRÈS resetForNextGame : \(currentGame.currentTurn)")
        print(" ")
        currentGame.scoresThisTurn = 0
    }

}
