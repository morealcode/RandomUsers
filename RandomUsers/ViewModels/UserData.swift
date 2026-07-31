//
//  UserData.swift
//  RandomUsers
//
//  Created by morealcode on 31/07/2026.
//

import Foundation
import Observation

// Rend la classe observable par SwiftUI.
// Quand "users" change, l'interface peut se mettre à jour.
@Observable
@MainActor
class UserData {

    // Contient le texte JSON récupéré depuis l'API
    // Pour le moment, la valeur est vide
    var users: String = ""

    init() {
        // Task permet d'appeler une fonction async
        // depuis l'initialiseur, qui n'est pas async
        Task {
            await loadUsers()
        }
    }

    // Récupère les utilisateurs depuis l'API
    func loadUsers() async {
        do {
            // On utilise "fetchedUsers" pour ne pas confondre
            // cette constante locale avec la propriété "users"
            let fetchedUsers = try await UserFetchingClient.getUsers()

            // Met à jour la propriété de la classe
            self.users = fetchedUsers

        } catch {
            // Affiche l'erreur dans la console en cas d'échec
            print("Impossible de récupérer les utilisateurs : \(error)")
        }
    }
}
