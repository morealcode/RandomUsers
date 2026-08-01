//
//  User.swift
//  RandomUsers
//
//  Created by morealcode on 31/07/2026.
//

import Foundation

// "nonisolated" indique que ce modèle
// n'appartient pas au MainActor.
//
// Il peut donc être décodé depuis n'importe quel contexte,
// notamment depuis les tests.
nonisolated struct Response: Decodable {
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

nonisolated struct User: Decodable, Identifiable {
    let id: String
    let name: Name

    var fullName: String {
        "\(name.title). \(name.first) \(name.last)"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)

        let loginInfo = try values.nestedContainer(
            keyedBy: LoginInfoCodingKeys.self,
            forKey: .login
        )
        id = try loginInfo.decode(String.self, forKey: .uuid)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case login
    }

    enum LoginInfoCodingKeys: String, CodingKey {
        case uuid
    }
}

nonisolated struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

/*
 API result look like this :

 {
       "gender": "female",
       "name": {
         "title": "Miss",
         "first": "Amparo",
         "last": "Cano"
       },
       "location": {
         "street": {
           "number": 1685,
           "name": "Avenida de América"
         },
         "city": "San Sebastián",
         "state": "Islas Baleares",
         "country": "Spain",
         "postcode": 67206,
         "coordinates": {
           "latitude": "33.3948",
           "longitude": "177.8469"
         },
         "timezone": {
           "offset": "-4:00",
           "description": "Atlantic Time (Canada), Caracas, La Paz"
         }
       },
       "email": "amparo.cano@example.com",
       "login": {
         "uuid": "22c48bac-94c6-423e-a93b-2354dc74c1e7",
         "username": "heavygorilla977",
         "password": "chains",
         "salt": "GEuMWDnu",
         "md5": "81f8cda2b13ca3dd2863ff853fc8789d",
         "sha1": "f7f5438aa8fa19cb5a4f4473ae5499708ad967fe",
         "sha256": "e6d7ac3a192039d12268e3be2172bf44b3c852785c6e2f4ef3a189bc32890daa"
       }
 }
 */
