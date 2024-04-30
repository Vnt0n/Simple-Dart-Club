//
//  GameViewModel.swift
//  DartClub
//
//  Created by Antoine on 27/04/2024.
//

import SwiftUI

struct Player {
    var name: String = ""
    var scores: [[Int]] = []
    var remainingScore: Int
}

struct Game {
    var players: [Player]
    var gameType: Int
    var currentTurn: Int = 1
}

class GameViewModel: ObservableObject {
    @Published var currentGame: Game
    @Published var gameStarted: Bool = false
    
    init(gameType: Int) {
        let initialPlayer = Player(name: "", scores: [], remainingScore: gameType)
        self.currentGame = Game(players: [initialPlayer], gameType: gameType)
    }
    
    func addPlayer() {
        if currentGame.players.count < 4 {
            currentGame.players.append(Player(name: "", scores: [], remainingScore: currentGame.gameType))
        }
    }
        
    func addScore(forPlayer index: Int, score: [Int]) {
        guard score.count == 3 else {
            return  // S'assurer que chaque score contient trois lancers
        }
        
        // Calculer le score total incluant le nouveau score
        let totalScoreWithNew = currentGame.players[index].scores.flatMap { $0 }.reduce(0, +) + score.reduce(0, +)
        
        // Vérifier si le nouveau total dépasse le gameType
        if totalScoreWithNew <= currentGame.gameType {
            // Mettre à jour le remainingScore normalement
            currentGame.players[index].remainingScore = currentGame.gameType - totalScoreWithNew
        }
        
        // Ajouter le score à l'historique du joueur indépendamment du résultat
        currentGame.players[index].scores.append(score)

        // Passer au tour suivant, indépendamment de si le score dépasse la limite
        if index == currentGame.players.count - 1 {
            currentGame.currentTurn += 1
        }
    }

    func remainingScore(forPlayer index: Int) -> Int {
        // Cette fonction retourne simplement le remainingScore actuel
        return currentGame.players[index].remainingScore
    }
}
