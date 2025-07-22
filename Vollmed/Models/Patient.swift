//
//  Patient.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 22/07/25.
//

import Foundation

struct PatientResponse: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let cpf: String
    let healthPlan: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
        case email
        case password = "senha"
        case phoneNumber = "telefone"
        case cpf
        case healthPlan = "planoSaude"
    }
}

struct PatientRequest: Codable {
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let cpf: String
    let healthPlan: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case email
        case password = "senha"
        case phoneNumber = "telefone"
        case cpf
        case healthPlan = "planoSaude"
    }
}
