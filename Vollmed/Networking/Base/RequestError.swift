//
//  RequestError.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 28/07/25.
//

import Foundation

enum RequestError: Error {
    case decodeFailed
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case custom(error: [String: Any]?)
    
    var customMessage: String {
        switch self {
        case .decodeFailed:
            return "Erro de decodificação"
        case .invalidURL:
            return "Erro de URL inválida"
        case .unauthorized:
            return "Erro de sessão expirada"
        case .custom(error: let errorData):
            if let jsonError = errorData?["error"] as? [String: Any] {
                let message = jsonError["message"] as? String ?? ""
                return message
            }
            return "Ops! Ocorreu um erro ao carregar as informações"
        default:
            return "Erro desconhecido"
        }
    }
}
