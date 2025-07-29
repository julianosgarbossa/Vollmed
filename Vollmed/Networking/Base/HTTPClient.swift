//
//  HTTPClient.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 28/07/25.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError> {
       
//        var urlComponets = URLComponents()
//        urlComponets.scheme = endpoint.scheme
//        urlComponets.host = endpoint.host
//        urlComponets.path = endpoint.path
//        urlComponets.port = 3000
        
//        guard let url = urlComponets.url else {
//            return .failure(.invalidURL)
//        }
        
        guard let url = URL(string: "https://private-597870-vollmed7.apiary-mock.com/specialists") else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
                
            case 200...299:
                guard let responseModel = responseModel else {
                    return .success(nil)
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decodeFailed)
                }
                
                return .success(decodedResponse)
            case 400:
                let errorResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print(errorResponse ?? [:])
                return .failure(.custom(error: errorResponse))
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unknown)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
