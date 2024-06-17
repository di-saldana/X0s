//
//  YourNameView.swift
//  X0s
//
//  Created by Dianelys Saldaña on 6/16/24.
//

import SwiftUI

struct YourNameView: View {
    @AppStorage("yourName") var yourName = ""
    @State private var userName = ""
    var body: some View {
        VStack {
            Text("Este es el nombre que será asociado con el dispositivo.")
            TextField("Nombre", text: $userName)
                .textFieldStyle(.roundedBorder)
            Button("Set") {
                yourName = userName
            }
            .buttonStyle(.borderedProminent)
            .disabled(userName.isEmpty)
            Spacer()
        }
        .padding()
        .inNavigationStack()
    }
}

#Preview {
    YourNameView()
}
