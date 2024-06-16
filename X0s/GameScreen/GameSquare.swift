//
//  GameSquare.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/15/24.
//

import SwiftUI

struct GameSquare {
    var id: Int
    var player: Player?
    
    var image: Image {
        if let player = player {
            return player.gamePiece.image
        } else {
            return Image("none-icon")
        }
    }
    
    static var reset: [GameSquare] {
        var squares = [GameSquare]()
        
        for index in 1...9 {
            squares.append(GameSquare(id: index))
        }
        return squares
    }
}
