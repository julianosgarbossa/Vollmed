//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 21/07/25.
//

import SwiftUI

struct CancelAppointmentView: View {
    
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
                print("consulta cancelada")
            } label: {
                ButtonView(text: "Cancelar Consulta", buttonType: .cancel)
            }
        }
        .padding()
        .navigationTitle("Cancelar Consulta")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CancelAppointmentView()
}
