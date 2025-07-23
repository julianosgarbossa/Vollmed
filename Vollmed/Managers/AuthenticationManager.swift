//
//  AutenticationManager.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 23/07/25.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientId: String?
    
    private init() {
        self.token = KeychainHelper.get(key: "token")
        self.patientId = KeychainHelper.get(key: "patientId")
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: "token")
        self.token = token
    }
    
    func removeToken() {
        KeychainHelper.remove(key: "token")
        self.token = nil
    }
    
    func savePatientId(patientId: String) {
        KeychainHelper.save(value: patientId, key: "patientId")
        self.patientId = patientId
    }
    
    func removePatientId() {
        KeychainHelper.remove(key: "patientId")
        self.patientId = nil
    }
}
