//
//  TabViewController.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 18/07/25.
//

import SwiftUI

struct TabViewController: View {
    
    private let service = WebService()
    
    @AppStorage("token") var token: String = ""
    @State private var selectedTab = 0
    @State private var showAlertLogout: Bool = false
    
    var body: some View {
        
        if token.isEmpty {
            NavigationStack {
                SignInView()
            }
        } else {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(systemName: "house")
                    }
                }
                .tag(0)
                
                NavigationStack {
                    MyAppointmentsView()
                }
                .tabItem {
                    Label {
                        Text("Consultas")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                }
                .tag(1)
            }
            .toolbar {
                if selectedTab == 0 {
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
            }
            .alert("Error", isPresented: $showAlertLogout) {
                Button("OK") {
                    showAlertLogout = false
                }
            } message: {
                Text("Ocorreu um erro ao realizar o logout do paciente. Tente novamente!")
            }
        }
        
    }
    
    // MARK: - Methods
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
    TabViewController()
}
