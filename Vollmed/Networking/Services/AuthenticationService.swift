//
//  AuthenticationService.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 28/07/25.
//

import Foundation

protocol AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError>
}

struct AuthenticationService: AuthenticationServiceable, HTTPClient {
    func logout() async -> Result<Bool?, RequestError> {
        return await sendRequest(endpoint: AuthenticationEndpoint.logout, responseModel: nil)
    }
}
