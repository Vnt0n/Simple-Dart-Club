//
//  GameViewModel.swift
//  DartClub
//
//  Created by Antoine on 27/04/2024.
//

import SwiftUI

struct GameRecord {
    var gameNumber: Int
    var finalScores: [Player]
}

struct Player {
    var name: String = ""
    var scores: [[Int]] = []
    var remainingScore: Int
    var remainingScoresPerTurn: [Int] = []  // Ajoutez cette ligne
}

struct Game {
    var players: [Player]
    var gameType: Int
    var currentTurn: Int = 1
    var scoresThisTurn: Int = 0
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
            return  // S'assurer que chaque score contient trois lancers
        }
        print("--------------------------------------------")
        print("FONCTION ADDSCORE")
        print(" ")
        print("currentTurn AVANT addScore : \(currentGame.currentTurn)")
        print(" ")
        
        // Ajouter le score à l'historique des scores du joueur
        var player = currentGame.players[index]
        player.scores.append(score)

        // Calculer le score total incluant le nouveau score
        let totalScoreWithNew = player.scores.flatMap { $0 }.reduce(0, +)

        // Mettre à jour le remainingScore en fonction du nouveau total
        let newRemainingScore = currentGame.gameType - totalScoreWithNew
        player.remainingScoresPerTurn.append(newRemainingScore)
        player.remainingScore = newRemainingScore  // Mettre à jour le remainingScore général

        // Sauvegarder les modifications
        currentGame.players[index] = player
        
        // Incrémenter le compteur de scores pour ce tour
        currentGame.scoresThisTurn += 1

        // Vérifier si tous les joueurs ont joué ce tour
        if currentGame.scoresThisTurn == currentGame.players.count {
            currentGame.currentTurn += 1  // Passer au tour suivant
            currentGame.scoresThisTurn = 0  // Réinitialiser le compteur pour le prochain tour
        }
        print("currentTurn APRÈS addScore : \(currentGame.currentTurn)")
        print(" ")
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

    func endGame() {
        print("--------------------------------------------")
        print("FONCTION ENDGAME")
        let record = GameRecord(gameNumber: gameCount, finalScores: currentGame.players)
        gameHistory.append(record)
        resetForNextGame() // Cette fonction réinitialise le jeu pour le prochain tour
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
