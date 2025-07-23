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
        do {
            if let result = try await self.service.getAllAppointmentsFromPatient(patientId: "4d475b97-2d76-41a4-8a91-07c5f95659f5") {
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
