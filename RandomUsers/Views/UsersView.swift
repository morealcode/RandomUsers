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
            List(userData.users) { user in
                Text(user.fullName)
            }
            .navigationTitle("Random Users")
        }
        .task {
            // .task exécute ce bloc lorsque la vue apparaît à l'écran
            // Il permet d'appeler du code asynchrone directement depuis une vue SwiftUI

            // "await" attend que la fonction loadUsers() termine son travail
            // Ici, loadUsers() récupère les utilisateurs depuis l'API
            await userData.loadUsers()
        }
    }
}

#Preview {
    UsersView()
}
