//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 17/07/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    @State private var selectedDate = Date()
    
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
                print(selectedDate.convertToString().convertDateStringToReadableDate())
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
    }
}

#Preview {
    ScheduleAppointmentView()
}
