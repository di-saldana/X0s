//
//  ContentView.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var game: GameService
    @StateObject var connectionManager: MPConnectionManager
    @State private var gameType: GameType = .peer
    @State private var opponentName = ""
    @State private var startGame = false
    @FocusState private var focus: Bool
    
    init(yourName: String) {
        _connectionManager = StateObject(wrappedValue: MPConnectionManager(yourName: UIDevice.current.name))
    }
    
    var body: some View {
        VStack {
            VStack {
                switch gameType {
                case .peer:
                    MPPeersView(startGame: $startGame)
                        .environmentObject(connectionManager)
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
        Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $startGame) {
            GameView()
                .environmentObject(connectionManager)
        }
        .inNavigationStack()
    }
}

#Preview {
    StartView(yourName: UIDevice.current.name)
        .environmentObject(GameService())
}
