//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    
    private let service = WebService()
    
    @State private var specialists: [Specialist] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.lightBlue)
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                ForEach(specialists) { specialist in
                    SpecialistCardView(specialist: specialist)
                        .padding(.bottom, 8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear() {
            Task {
                await self.getSpecialists()
            }
        }
        .alert("Error", isPresented: $showAlert, actions: {
            Button("Tentar Novamente") {
                Task {
                    await self.getSpecialists()
                }
            }
        }, message: {
            Text(alertMessage)
        })
    }
    
    // MARK: - Methods
    private func getSpecialists() async {
        do {
            let result = try await self.service.getAllSpecialists()
            if let result {
                self.specialists = result
            }
        } catch {
            self.alertMessage = "Ocorreu um erro ao obter os especialistas: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

#Preview {
    HomeView()
}

