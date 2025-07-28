//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    
    private var viewModel = HomeViewModel(service: HomeNetworkingService(),
                                          authService: AuthenticationService())
    
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
        .alert("Erro", isPresented: $showAlert, actions: {
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
                        await self.logoutPatient()
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
        .alert("Erro", isPresented: $showAlertLogout) {
            Button("OK") {
                showAlertLogout = false
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    // MARK: - Methods
    private func getSpecialists() async {
        do {
            guard let response = try await self.viewModel.getSpecialists() else { return }
            if response.isEmpty {
                self.showAlert = true
                self.alertMessage = "Nenhum especialista cadastrado. Tente Novamente!"
            } else {
                self.specialists = response
            }
        } catch {
            self.showAlert = true
            self.alertMessage = "Ocorreu um erro ao buscar os especialistas: \(error.localizedDescription) Tente novamente!"
        }
    }
    
    private func logoutPatient() async {
        do {
            if try await self.viewModel.logoutPatient() == false {
                self.alertMessage = "Ocorreu um erro ao realizar logout do paciente. Tente Novamente!"
                self.showAlertLogout = true
            }
        } catch {
            self.alertMessage = "Ocorreu um erro ao realizar logout do paciente: \(error.localizedDescription) Tente Novamente!"
            self.showAlertLogout = true
        }
    }
}

#Preview {
    HomeView()
}

