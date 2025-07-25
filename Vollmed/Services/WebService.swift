//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    private let imageCache = NSCache<NSString, UIImage>()
    private var authManager = AuthenticationManager.shared

    // MARK: - Methods GET
    func downloadImage(imageURL: String) async throws -> UIImage? {
        
        guard let url = URL(string: imageURL) else {
            print("Erro na URL!")
            return nil
        }
        
        // Verifica cache
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        // Salva imagem no cache
        imageCache.setObject(image, forKey: imageURL as NSString)
        
        return image
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        return specialists
    }
    
    func getAllAppointmentsFromPatient(patientId: String) async throws -> [Appointment]? {
        let endpoint = baseURL + "/paciente/\(patientId)/consultas"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = authManager.token else {
            print("Token não encontrado!")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        let appointmentsFromPatient = try JSONDecoder().decode([Appointment].self, from: data)
        
        return appointmentsFromPatient
    }
    
    // MARK: - Methods POST
    func scheduleAppointment(specialistId: String,
                             patientId: String,
                             date: String) async throws -> ScheduleAppointmentResponse? {
        
        let endpoint = baseURL + "/consulta"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = authManager.token else {
            print("Token não encontrado!")
            return nil
        }
        
        let appointment = ScheduleAppointmentRequest(specialist: specialistId,
                                                     patient: patientId,
                                                     date: date)
        
        let jsonData = try JSONEncoder().encode(appointment)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
    }
    
    func registerPatient(patient: PatientRequest) async throws -> PatientResponse? {
        
        let endpoint = baseURL + "/paciente"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let jsonData = try JSONEncoder().encode(patient)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
 
        let patientResponse = try JSONDecoder().decode(PatientResponse.self, from: data)
        
        return patientResponse
    }
    
    func loginPatient(email: String, password: String) async throws -> LoginResponse? {
        
        let endpoint = baseURL + "/auth/login"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let loginPatient = LoginRequest(email: email,
                                        password: password)
        
        let jsonData = try JSONEncoder().encode(loginPatient)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let loginPatientResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        return loginPatientResponse
    }
    
    func logoutPatient() async throws -> Bool {
    
        let endpoint = baseURL + "/auth/logout"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return false
        }
        
        guard let token = authManager.token else {
            print("Token não encontrado!")
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return true
        } else {
            return false
        }
    }

    
    // MARK: - Methods PATCH
    func rescheduledAppointment(appointmentId: String, newDate: String) async throws -> ScheduleAppointmentResponse? {
        
        let endpoint = baseURL + "/consulta/\(appointmentId)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = authManager.token else {
            print("Token não encontrado!")
            return nil
        }
        
        let requestData: [String : String] = ["data": newDate]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
    }
    
    // MARK: - Methods DELETE
    func cancelAppointment(appointmentId: String, reasonToCancel: String) async throws -> Bool {
        
        let endpoint = baseURL + "/consulta/\(appointmentId)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return false
        }
        
        guard let token = authManager.token else {
            print("Token não encontrado!")
            return false
        }
        
        let requestData: [String : String] = ["motivo_cancelamento": reasonToCancel]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return true
        }
        
        return false
    }
}
