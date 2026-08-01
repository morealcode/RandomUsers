//
//  RandomUsersTests.swift
//  RandomUsersTests
//
//  Created by morealcode on 31/07/2026.
//

import Foundation
import Testing

@testable import RandomUsers

struct RandomUsersTests {

    // Indique à Swift Testing que cette fonction est un test
    @Test
    func userModel() throws {

        // Affiche un message pour vérifier
        // que le test commence bien
        print("Début du test")

        // Récupère les données du fichier randomUsers.json
        let jsonData = try getTestJSONData()

        // Affiche le nombre d'octets contenus dans le fichier
        print("Taille du fichier JSON : \(jsonData.count) octets")

        // Transforme les données JSON en objet Response
        // Si le décodage échoue, le test échoue automatiquement
        let response = try JSONDecoder().decode(
            Response.self,
            from: jsonData
        )

        // Affiche le nombre d'utilisateurs décodés
        print("Nombre d'utilisateurs : \(response.users.count)")

        // Parcourt tous les utilisateurs décodés
        for user in response.users {

            // Affiche le nom complet de chaque utilisateur
            print("Utilisateur : \(user.fullName)")
        }

        // Vérifie que le tableau contient au moins un utilisateur
        #expect(response.users.isEmpty == false)

        // Affiche un message si le code arrive jusqu'ici
        print("Fin du test : décodage réussi")
    }

    // Récupère le contenu du fichier randomUsers.json
    private func getTestJSONData() throws -> Data {

        // Récupère le Bundle de la cible de tests
        let testBundle = Bundle(for: TestBundleToken.self)

        // Cherche le fichier randomUsers.json
        // #require arrête le test si le fichier est introuvable
        let fileURL = try #require(
            testBundle.url(
                forResource: "testRandomUsers",
                withExtension: "json"
            ),
            "Le fichier testRandomUsers.json est introuvable"
        )

        // Lit et retourne les données du fichier
        return try Data(contentsOf: fileURL)
    }
}

// Cette classe vide permet de retrouver
// le Bundle de la cible de tests
private final class TestBundleToken {}
