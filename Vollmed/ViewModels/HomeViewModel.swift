//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 24/07/25.
//

import Foundation

struct HomeViewModel {
    
    // MARK: - Attributes
    private let service: HomeServiceable
    private let authService: AuthenticationServiceable
    private var authManager = AuthenticationManager.shared
    
    // MARK: - Init
    init(service: HomeServiceable, authService: AuthenticationServiceable) {
        self.service = service
        self.authService = authService
    }
    
    // MARK: - Class Methods
    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
        
    }
    
    func logoutPatient() async -> Bool {
        let result = try await authService.logout()
        
        switch result {
        case .success(_):
            self.authManager.removeToken()
            self.authManager.removePatientId()
            return true
        case .failure(let error):
            print(error.localizedDescription)
            return false
        }
    }
}
