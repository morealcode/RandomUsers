//
//  UserFetchingClient.swift
//  RandomUsers
//
//  Created by morealcode on 31/07/2026.
//

import Foundation

struct UserFetchingClient {

    // URL de l'API Random User
    // Elle est "static" car elle appartient directement à la structure
    // et "private" car elle n'est utilisée qu'à l'intérieur de cette structure
    private static let url = URL(
        string: "https://randomuser.me/api/?results=10&format=pretty"
    )!

    // Cette fonction :
    // - est async car elle effectue une requête réseau
    // - peut générer une erreur, donc elle utilise throws
    // - retourne le contenu de la réponse sous forme de String
    static func getUsers() async throws -> Response {

        // Envoie une requête vers l'URL
        // data contient les données reçues
        // response contient les informations HTTP de la réponse
        let (data, response) = try await URLSession.shared.data(from: url)

        // Vérifie que la réponse est bien une réponse HTTP
        // et que le code est compris entre 200 et 299
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {

            // Lance une erreur si le serveur retourne une mauvaise réponse
            throw URLError(.badServerResponse)
        }

        // Transforme les données JSON reçues en objet Swift
        // Response.self indique le type d'objet que JSONDecoder doit créer
        // Cette opération peut générer une erreur, donc elle utilise "try"
        let value = try JSONDecoder().decode(
            Response.self,
            from: data
        )

        // Retourne le texte reçu depuis l'API
        return value
    }
}
