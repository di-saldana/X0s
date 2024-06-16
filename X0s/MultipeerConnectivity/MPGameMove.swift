//
//  MPGameMove.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/15/24.
//

import Foundation

struct MPGameMove: Codable {
    enum Action: Int, Codable {
        case start, move, reset, end
    }

    let action: Action
    let playerName: String?
    let index: Int?

    func data() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
