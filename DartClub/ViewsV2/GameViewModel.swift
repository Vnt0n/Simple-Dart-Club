//
//  GameViewModel.swift
//  DartClub
//
//  Created by Antoine on 27/04/2024.
//

import SwiftUI

struct Player {
    var name: String = ""
    var scores: [[Int]] = []  // List of scores for each turn, each score is an array of three throws
}

struct Game {
    var players: [Player]
    var gameType: Int  // 301 or 501 for example
    var currentTurn: Int = 0
}

class GameViewModel: ObservableObject {
    @Published var currentGame: Game
    @Published var gameStarted: Bool = false

    init(gameType: Int, playerCount: Int) {
        let players = Array(repeating: Player(), count: playerCount)
        self.currentGame = Game(players: players, gameType: gameType)
    }
    
    func addScore(forPlayer index: Int, score: [Int]) {
        guard score.count == 3 else { return }
        currentGame.players[index].scores.append(score)
        currentGame.currentTurn += 1
    }
    
    func undoLastScore(forPlayer index: Int) {
        if !currentGame.players[index].scores.isEmpty {
            currentGame.players[index].scores.removeLast()
        }
    }
}

