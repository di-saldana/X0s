//
//  GameService.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import SwiftUI

@MainActor
class GameService: ObservableObject {
    @Published var player1 = Player(gamePiece: .x, name: "Jugador 1")
    @Published var player2 = Player(gamePiece: .o, name: "Jugador 2")
    @Published var possibleMoves = Move.all
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    
    var gameType = GameType.peer
    
    var currentPlayer1: Player {
        if player1.isCurrent {
            return player1
        } else {
            return player2
        }
    }
    
    var currentPlayer: Player {
        player1.isCurrent ? player1 : player2
    }
    
    var gameStarted: Bool {
        player1.isCurrent || player2.isCurrent
    }
    
    var boardDisabled: Bool {
        gameOver || !gameStarted
    }
    
    func setupGame1(gameType: GameType, player1Name: String, player2Name: String) {
        switch gameType {
        case .peer:
            self.gameType = .peer
        }
        player1.name = player1Name
    }
    
    func setupGame(gameType: GameType, player1Name: String, player2Name: String) {
        self.gameType = gameType
        player1.name = player1Name
        player2.name = player2Name
        reset()  // Ensure the game is reset whenever it's set up
    }
    
    func reset() {
        player1.isCurrent = false
        player2.isCurrent = false
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Move.all
        gameBoard = GameSquare.reset
    }
    
    func updateMoves(index: Int) {
        if player1.isCurrent {
            player1.moves.append(index + 1)
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index + 1)
            gameBoard[index].player = player2
        }
    }
    
    func checkIfWinner() {
        if player1.isWinner || player2.isWinner {
            gameOver = true
        }
    }
    
    func toggleCurrent() {
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    func makeMove(at index: Int) {
        if gameBoard[index].player == nil {
            withAnimation {
                updateMoves(index: index)
            }
            checkIfWinner()
            if !gameOver {
                if let matchingIndex = possibleMoves.firstIndex(where: {$0 == (index + 1)}) {
                    possibleMoves.remove(at: matchingIndex)
                }
                toggleCurrent()
            }
            if possibleMoves.isEmpty {
                gameOver = true
            }
        }
    }
}
