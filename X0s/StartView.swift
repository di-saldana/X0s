//
//  ContentView.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import SwiftUI

struct StartView: View {
    @State private var gameType: GameType = .peer
    @State private var yourName = ""
    @State private var opponentNamer = ""
    @State private var startGame = false
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack {
            Button("Start Game") {
                focus = false
                startGame.toggle()
            }
            .buttonStyle(.borderedProminent)
            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Xs and Os")
        .fullScreenCover(isPresented: $startGame, content: {
            GameView()
        })
        .inNavigationStack()
    }
}

#Preview {
    StartView()
}
