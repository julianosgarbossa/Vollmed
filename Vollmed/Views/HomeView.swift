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
    @State private var showAlertLogout: Bool = false
    
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
        .padding(.top, 0)
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await logoutPatient()
                    }
                } label: {
                    HStack(spacing: 2) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                    }
                }
                
            }
        }
        .navigationTitle("Especialistas")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $showAlertLogout) {
            Button("OK") {
                showAlertLogout = false
            }
        } message: {
            Text("Ocorreu um erro ao realizar o logout do paciente. Tente novamente!")
        }
    }
    
    // MARK: - Methods
    private func getSpecialists() async {
        do {
            let result = try await self.service.getAllSpecialists()
            if let result {
                self.specialists = result
            }
        } catch {
            showAlert = true
            self.alertMessage = "Ocorreu um erro ao obter os especialistas: \(error.localizedDescription)"
        }
    }
    
    private func logoutPatient() async {
        do {
            if try await self.service.logoutPatient() {
                UserDefaultsHelper.remove(key: "token")
            } else {
                self.showAlertLogout = true
            }
        } catch {
            self.showAlertLogout = true
            print("Ocorreu um erro ao realizar o logout do paciente: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HomeView()
}

