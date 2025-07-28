//
//  HomeNetworkingService.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 28/07/25.
//

import Foundation

protocol HomeServiceable {
    func getAllSpecialists() async -> Result<[Specialist]?, RequestError>
}

struct HomeNetworkingService: HomeServiceable, HTTPClient {
    func getAllSpecialists() async -> Result<[Specialist]?, RequestError> {
        return await sendRequest(endpoint: HomeEndpoint.getAllSpecialists, responseModel: [Specialist].self)
    }
}
