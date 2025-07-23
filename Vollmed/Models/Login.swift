//
//  Login.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 22/07/25.
//

import Foundation

struct LoginResponse: Identifiable, Codable {
    let id: String
    let auth: Bool
    let token: String
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case auth
        case token
        case path = "rota"
    }
}

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}
