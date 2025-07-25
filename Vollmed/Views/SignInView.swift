//
//  SignInView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 21/07/25.
//

import SwiftUI

struct SignInView: View {
    
    private let service = WebService()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
    
    private var authManager = AuthenticationManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
                    
                    Text("Olá!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.accent)
                    
                    Text("Preencha para acessar sua conta.")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    
                    TextView(text: "Email")
                    
                    TextFieldView(placeholder: "Insira seu email", text: $email, keyboardType: .emailAddress)
                    
                    TextView(text: "Senha")
                    
                    SecureFieldView(placeholder: "Insira sua senha", text: $password)
                    
                    Button(action:{
                        Task {
                            await self.loginPatient()
                        }
                    }, label: {
                        ButtonView(text: "Entrar")
                    })
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Ainda não possui uma conta? Cadastre-se.")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding()
                .disabled(isLoading) // Desabilita interação durante loading
                .blur(radius: isLoading ? 2 : 0) // Desfoca o fundo quando está carregando
                
                if isLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    ProgressView("Carregando...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
            }
        }
        .alert("Error", isPresented: $showAlert, actions: {
            Button("OK") {
                showAlert = false
            }
        }, message: {
            Text("Erro ao efetuar o login do paciente. Tente novamente!")
        })
    }
    
    //MARK: - Methods
    private func loginPatient() async {
        self.isLoading = true
        do {
            if let result = try await self.service.loginPatient(email: email, password: password) {
                authManager.saveToken(token: result.token)
                authManager.savePatientId(patientId: result.id)
                self.isLoading = false
            } else {
                self.isLoading = false
                showAlert = true
            }
        } catch {
            self.isLoading = false
            showAlert = true
            print("Ocorreu um erro ao realizar o login do paciente: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SignInView()
}
