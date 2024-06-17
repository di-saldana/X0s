//
//  MPPeersView.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/15/24.
//

import SwiftUI

struct MPPeersView: View {
    
    @EnvironmentObject var connectionManager: MPConnectionManager
    @EnvironmentObject var game: GameService
    @Binding var startGame: Bool
    
    var body: some View {
        VStack {
            Text("Jugadores disponibles")
            List(connectionManager.availablePeers, id: \.self) { peer in
                HStack {
                    Text(peer.displayName)
                    Spacer()
                    Button("Seleccionar") {
                        print("Invitando a peer: \(peer.displayName)")
                        game.gameType = .peer
                        connectionManager.nearbyServiceBrowser.invitePeer(peer, to: connectionManager.session, withContext: nil, timeout: 30)
                        game.player1.name = connectionManager.myPeerId.displayName
                        game.player2.name = peer.displayName
                    }
                    .buttonStyle(.borderedProminent)
                }
                .alert("Invitación recibida de \(connectionManager.receivedInviteFrom?.displayName ?? "Desconocido")",
                       isPresented: $connectionManager.receivedInvite) {
                    Button("Aceptar") {
                        print("Invitacion aceptada de peer: \(connectionManager.receivedInviteFrom?.displayName ?? "Desconocido")")
                        if let invitationHandler = connectionManager.invitationHandler {
                            invitationHandler(true, connectionManager.session)
                            game.player1.name = connectionManager.receivedInviteFrom?.displayName ?? "Desconocido"
                            game.player2.name = connectionManager.myPeerId.displayName
                            game.gameType = .peer
                        }
                    }
                    Button("Rechazar") {
                        print("Invitacion rechazada de peer: \(connectionManager.receivedInviteFrom?.displayName ?? "Desconocido")")
                        if let invitationHandler = connectionManager.invitationHandler {
                            invitationHandler(false, nil)
                        }
                    }
                }
            }
        }
        .onAppear {
            connectionManager.isAvailableToPlay = true
            connectionManager.startBrowsing()
        }
        .onDisappear {
            connectionManager.stopBrowsing()
            connectionManager.stopAdvertising()
            connectionManager.isAvailableToPlay = false
        }
        .onChange(of: connectionManager.paired) {
            startGame = connectionManager.paired
        }
    }
}

#Preview {
    MPPeersView(startGame: .constant(false))
        .environmentObject(MPConnectionManager(yourName: UIDevice.current.name))
        .environmentObject(GameService())
}
