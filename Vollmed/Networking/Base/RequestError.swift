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
    case custom(_ error: [String: Any])
    
    var customMessage: String {
        switch self {
        case .decodeFailed:
            return "Erro de decodificação"
        case .invalidURL:
            return "Erro de URL inválida"
        case .unauthorized:
            return "Erro de sessão expirada"
        default:
            return "Erro desconhecido"
        }
    }
}
