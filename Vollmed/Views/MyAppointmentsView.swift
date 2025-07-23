//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 18/07/25.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    private let service = WebService()
    @State private var appointments: [Appointment] = []
    private var authManager = AuthenticationManager.shared
    
    var body: some View {
        ZStack {
            if appointments.isEmpty {
                Text("Não há nenhuma consulta agendada no momento!")
                    .multilineTextAlignment(.center)
                    .bold()
                    .font(.title2)
                    .foregroundStyle(.cancel)
            } else {
                ScrollView {
                    VStack {
                        ForEach(appointments) { appointment in
                            SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                        }
                    }
                }
                .padding(.top, 0)
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Minhas Consultas")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear() {
            Task {
                await self.getAppointmentsFromPatient()
            }
        }
    }
    
    // MARK: - Methods
    private func getAppointmentsFromPatient() async {
        guard let patientId = authManager.patientId else {
            return
        }
        do {
            if let result = try await self.service.getAllAppointmentsFromPatient(patientId: patientId) {
                self.appointments = result
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    MyAppointmentsView()
}
