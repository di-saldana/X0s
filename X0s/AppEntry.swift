//
//  X0sApp.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/14/24.
//

import SwiftUI

@main
struct AppEntry: App {
    @AppStorage("yourName") var yourName = ""
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            StartView(yourName: UIDevice.current.name)
                .environmentObject(game)
        }
    }
}
