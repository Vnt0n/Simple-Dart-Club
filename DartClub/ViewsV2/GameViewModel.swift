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
        let initialPlayer = Player(name: "", scores: [], remainingScore: gameType)  // Assurez-vous que les propriétés sont correctement initialisées
        self.currentGame = Game(players: [initialPlayer], gameType: gameType)
    }
    
    func addPlayer() {
        if currentGame.players.count < 4 {
            currentGame.players.append(Player(remainingScore: currentGame.gameType))
        }
    }
        
    func addScore(forPlayer index: Int, score: [Int]) {

        print("----------------------------------------")
        print("Function addScore OK")
        print("Tentative d'ajouter un score: \(score)")
        
        guard score.count == 3 else {
            
            print("Score incorrect, attendu 3 valeurs, reçu : \(score.count)")
            
            return
        }
        
        currentGame.players[index].scores.append(score)
        
        if index == currentGame.players.count - 1 {
            
            currentGame.currentTurn += 1
            
        }
        
        print("Current turn : \(currentGame.currentTurn)")
    }

    func remainingScore(forPlayer index: Int) -> Int {
        let totalScore = currentGame.players[index].scores.flatMap { $0 }.reduce(0, +)
        return currentGame.gameType - totalScore
    }
    
//    func undoLastScore() {
//        print("----------------------------------------")
//        print("Function undoLastScore 01")
//
//        if currentGame.currentTurn > 1 || !currentGame.players.first!.scores.isEmpty {
//            // Déterminez le joueur précédent
//            var previousPlayerIndex = currentGame.currentTurn - 1
//            if previousPlayerIndex < 0 {
//                previousPlayerIndex = currentGame.players.count - 1  // Boucle au dernier joueur si c'était le premier tour
//            }
//
//            // Supprimer le dernier score du joueur précédent
//            if !currentGame.players[previousPlayerIndex].scores.isEmpty {
//                currentGame.players[previousPlayerIndex].scores.removeLast()
//            }
//
//            // Mettre à jour le tour actuel
//            if currentGame.currentTurn > 1 {
//                currentGame.currentTurn -= 1
//            } else {
//                // Si c'est le premier tour, nous devons gérer cela spécifiquement (par exemple, ne rien faire ou ajuster autrement)
//            }
//        } else {
//            print("No scores to undo.")
//        }
//    }

}
