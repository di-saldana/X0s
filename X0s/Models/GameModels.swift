//
//  GameModels.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import SwiftUI

enum GamePiece: String {
    case x, o
    var image: Image {
        Image(self.rawValue)
    }
}

enum Move {
    static var all = [1,2,3,4,5,6,7,8,9]
    static var winningMoves = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
    ]
}

struct Player {
    let gamePiece: GamePiece
    let name: String
    
    var moves: [Int] = []
    var isCurrent = false
    
    var isWinner : Bool {
        for moves in Move.winningMoves {
            if moves.allSatisfy(self.moves.contains) {
                return true
            }
        }
        return false
    }
}

