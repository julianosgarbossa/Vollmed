//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 21/07/25.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    var appointmentId: String
    private let service = WebService()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var appointmentIsCanceled: Bool = false
    @State private var showAlert: Bool = false
    @State private var reasonToCancel = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .clipShape(.rect(cornerRadius: 16))
                .frame(maxHeight: 300)
            
            Button {
                Task {
                    await self.cancelAppointments()
                }
            } label: {
                ButtonView(text: "Cancelar Consulta", buttonType: .cancel)
            }
        }
        .padding()
        .navigationTitle("Cancelar Consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(appointmentIsCanceled ? "Sucesso!" : "Error!", isPresented: $showAlert, actions: {
            Button("OK") {
                showAlert = false
                if appointmentIsCanceled {
                    self.dismiss()
                }
            }
        }, message: {
            Text(appointmentIsCanceled ? "Consulta cancelada com sucesso." : "Erro ao cancelar a consulta. Tente novamente!")
        })
    }
    
    // MARK: - Methods
    private func cancelAppointments() async {
        do {
            let result = try await self.service.cancelAppointment(appointmentId: appointmentId, reasonToCancel: reasonToCancel)
            if result {
                self.appointmentIsCanceled = true
            }
            self.showAlert = true
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentId: "f93e79a0-fe29-486b-bf11-48f84156033c")
}
