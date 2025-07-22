//
//  SignUpView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 21/07/25.
//

import SwiftUI

struct SignUpView: View {
    
    private let service = WebService()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var healthPlan: String
    
    @State private var showAlert: Bool = false
    @State private var isPatientRegistered: Bool = false
    
    let healthPlans: [String] = [
        "Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "São Francisco Saúde", "Golden Cross", "Medial Saúde", "América Saúde", "Outro"
    ]
    
    init() {
        self.healthPlan = healthPlans[0]
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
                    .padding(.vertical)
                
                Text("Olá, boas vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Insira seus dados para criar uma conta.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                TextView(text: "Nome")
                
                TextFieldView(placeholder: "Insira seu nome completo", text: $name, textInputAutocapitalization: .words)
                
                TextView(text: "Email")
                
                TextFieldView(placeholder: "Insira o seu email", text: $email, keyboardType: .emailAddress)
                
                TextView(text: "Senha")
                
                SecureFieldView(placeholder: "Insira sua senha", text: $password)
                
                TextView(text: "Telefone")
                
                TextFieldView(placeholder: "Insira o seu telefone", text: $phoneNumber, keyboardType: .numberPad)
                
                TextView(text: "CPF")
                
                TextFieldView(placeholder: "Insira o seu CPF", text: $cpf, keyboardType: .numberPad)
                
                TextView(text: "Selecione o seu plano de saúde")
                
                Picker("Plano de saúde", selection: $healthPlan) {
                    ForEach(healthPlans, id: \.self) { healhPlan in
                        Text(healhPlan)
                    }
                }
                .pickerStyle(.menu)
                
                Button {
                    Task {
                        await self.registerPatient()
                    }
                } label: {
                    ButtonView(text: "Cadastrar")
                }
                
                Button {
                    self.dismiss()
                } label: {
                    Text("Já possuí uma conta? Faça o login!")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .padding()
        .alert(isPatientRegistered ? "Sucesso" : "Error", isPresented: $showAlert, actions: {
            Button("OK") {
                showAlert = false
                if isPatientRegistered {
                    self.dismiss()
                }
            }
        }, message: {
            Text(isPatientRegistered ? "Paciente registrado com sucesso." : "Erro ao registar paciente. Tente novamente!")
        })
    }
    
    // MARK: - Methods
    private func registerPatient() async {
        let patient = PatientRequest(name: self.name,
                                     email: self.email,
                                     password: self.password,
                                     phoneNumber: self.phoneNumber,
                                     cpf: self.cpf,
                                     healthPlan: self.healthPlan)
        do {
            if let _ = try await self.service.registerPatient(patient: patient) {
                self.isPatientRegistered = true
            }
            self.showAlert = true
        } catch  {
            self.showAlert = true
            print("Ocorreu um erro ao cadastrar o paciente: \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    SignUpView()
}
