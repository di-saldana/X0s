//
//  ContentView.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import SwiftUI

struct StartView: View {
    @State private var yourName = ""
    @State private var opponentName = ""
    @State private var startGame = false
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}

#Preview {
    StartView()
}
