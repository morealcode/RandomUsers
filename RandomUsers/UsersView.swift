//
//  UsersView.swift
//  RandomUsers
//
//  Created by morealcode on 31/07/2026.
//

import SwiftUI

struct UsersView: View {
    // La vue crée et conserve son instance de UserData
    @State private var userData = UserData()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {

                Text("Raw JSON Data:")
                    .font(.headline)

                ScrollView {
                    // Affiche le texte JSON reçu depuis l'API
                    Text(userData.users)
                        .font(.system(.body, design: .monospaced))
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .textSelection(.enabled)
                }
            }
            .padding()
            .navigationTitle("Random Users")
        }
    }
}

#Preview {
    UsersView()
}
