//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 17/07/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    private let service = WebService()
    
    var specialistId: String
    
    @State private var selectedDate = Date()
    @State private var showAlert: Bool = false
    @State private var isAppointmentScheduled: Bool = false
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button {
                Task {
                    await self.scheduleAppointment()
                }
            } label: {
                ButtonView(text: "Agendar Consulta")
            }
        }
        .padding()
        .navigationTitle("Agendar Consulta")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso!" : "Error!", isPresented: $showAlert, actions: {
            Button("OK") {
                showAlert = false
            }
        }, message: {
            Text(isAppointmentScheduled ? "Consulta agendada com sucesso." : "Ocorreu um erro ao agendar a consulta. Por favor tente novamente.")
        })
    }
    
    // MARK: - Methods
    private func scheduleAppointment() async {
        do {
            if let _ = try await self.service.scheduleAppointment(specialistId: specialistId, patientId: "4d475b97-2d76-41a4-8a91-07c5f95659f5", date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
            showAlert = true
        } catch {
            isAppointmentScheduled = false
            showAlert = true
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistId: "f3e1b5d3-3462-491d-b83d-622790091f2d")
}
