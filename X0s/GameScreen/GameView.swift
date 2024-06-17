//
//  GameView.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import SwiftUI

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: GameService
    @EnvironmentObject var connectionManager: MPConnectionManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy({ $0 == false }) {
                Text("Selecciona un jugador para comenzar:")
            }
            Spacer(minLength: 20)
            HStack {
                Button(action: {
                    game.player1.isCurrent = true
                    if game.gameType == .peer {
                        let gameMove = MPGameMove(action: .start, playerName: game.player1.name, index: nil)
                        connectionManager.send(gameMove: gameMove)
                    }
                }) {
                    Text(game.player1.name)
                }
                .buttonStyle(PlayerButtonStyle(player: game.player1))
                
                Button(action: {
                    game.player2.isCurrent = true
                    if game.gameType == .peer {
                        let gameMove = MPGameMove(action: .start, playerName: game.player2.name, index: nil)
                        connectionManager.send(gameMove: gameMove)
                    }
                }) {
                    Text(game.player2.name)
                }
                .buttonStyle(PlayerButtonStyle(player: game.player2))
            }
            .disabled(game.gameStarted)
            
            VStack {
                HStack {
                    ForEach(0...2, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
                HStack {
                    ForEach(3...5, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
                HStack {
                    ForEach(6...8, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
            }
            .disabled(game.boardDisabled ||
                      (game.gameType == .peer &&
                      connectionManager.myPeerId.displayName != game.currentPlayer.name))
            
            Spacer()
            VStack {
                if game.gameOver {
                    Text("Game Over")
                        .font(.largeTitle)
                    if game.possibleMoves.isEmpty {
                        Text("Nadie ha ganado")
                    } else {
                        Text("\(game.currentPlayer.name) ha ganado!")
                    }
                    Button(action: {
                        game.reset()
                        if game.gameType == .peer {
                            let gameMove = MPGameMove(action: .reset, playerName: nil, index: nil)
                            connectionManager.send(gameMove: gameMove)
                        }
                    }) {
                        Text("Nueva Partida")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                    if game.gameType == .peer {
                        let gameMove = MPGameMove(action: .end, playerName: nil, index: nil)
                        connectionManager.send(gameMove: gameMove)
                    }
                }) {
                    Text("Salir")
                }
                .buttonStyle(.bordered)
            }
        }
        .onAppear {
            game.reset()
            if game.gameType == .peer {
                connectionManager.setup(game: game)
            }
        }
        .inNavigationStack()
    }
}

#Preview {
    GameView()
        .environmentObject(GameService())
        .environmentObject(MPConnectionManager(yourName: UIDevice.current.name))
}

struct PlayerButtonStyle: ButtonStyle {
    let player: Player
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(player.isCurrent ? Color.indigo : Color.gray)
            )
            .foregroundColor(.white)
    }
}

