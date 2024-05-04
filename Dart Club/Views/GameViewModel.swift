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
        
    func addScore(forPlayer index: Int, score: [Int]) {
        guard score.count == 3 else {
            return  // Assurer que chaque score contient trois lancers
        }

        var player = currentGame.players[index]
        player.scores.append(score)  // Ajouter toujours le score à l'historique

        // Calculer le score total pour ce tour à partir du dernier remainingScore valide
        let lastValidRemainingScore = player.remainingScoresPerTurn.last ?? currentGame.gameType
        let scoreTotalForTurn = score.reduce(0, +)
        let newRemainingScore = lastValidRemainingScore - scoreTotalForTurn

        if newRemainingScore < 0 {
            // Si le score est négatif, considérer cela comme un bust et ne pas mettre à jour le remainingScore
            // Enregistrer le dernier remainingScore valide à la place du score négatif pour ce tour
            print("Bust! Score remains the same at \(lastValidRemainingScore), recording \(lastValidRemainingScore) for this turn.")
            player.remainingScoresPerTurn.append(lastValidRemainingScore)  // Ajouter le dernier valide à nouveau
            player.isBusted = true
        } else {
            // Sinon, mettre à jour le remainingScore avec le nouveau calculé et ajouter à l'historique des scores valides
            player.remainingScore = newRemainingScore
            player.remainingScoresPerTurn.append(newRemainingScore)  // Enregistrer ce remainingScore comme valide
            player.isBusted = false
         }

        // Sauvegarder les modifications dans le tableau des joueurs
        currentGame.players[index] = player

        // Gérer l'incrémentation des tours
        currentGame.scoresThisTurn += 1
        if currentGame.scoresThisTurn == currentGame.players.count {
            currentGame.currentTurn += 1
            currentGame.scoresThisTurn = 0
        }
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
        print("--------------------------------------------")
        print("FONCTION ENDGAME")
        let winners = currentGame.players.filter { $0.remainingScore == 0 }
        let record = GameRecord(gameNumber: gameCount, finalScores: currentGame.players, winners: winners)
        gameHistory.append(record)
        resetForNextGame() // Cette fonction réinitialise le jeu pour le prochain tour
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
