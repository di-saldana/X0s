//
//  GameService.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import Foundation

class GameService: ObservableObject {
    @Published var player1 = Player(gamePiece: .x, name: "Player1")
    @Published var player2 = Player(gamePiece: .o, name: "Player2")
    @Published var possibleMoves = Move.all
    @Published var movesTaken = [Int]()
    @Published var gameOver = false
    
    var gameType = GameType.peer
    
    var currentPlayer: Player {
        if player1.isCurrent {
            return player1
        } else {
            return player2
        }
    }
    
    var gameStarted: Bool {
        player1.isCurrent || player2.isCurrent
    }
    
    var boardDisabled: Bool {
        gameOver || !gameStarted
    }
    
}
