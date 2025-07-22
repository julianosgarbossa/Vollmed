//
//  SignUpView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 21/07/25.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var healthPlan: String
    
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
                
                Text("Nome")
                    .font(.title3)
                    .foregroundStyle(.accent)
                    .bold()
                
                TextField("Insira seu nome completo", text: $name)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 14))
                    .autocorrectionDisabled()
                
                Text("Email")
                    .font(.title3)
                    .foregroundStyle(.accent)
                    .bold()
                
                TextField("Insira o seu email", text: $email)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 14))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                Text("Senha")
                    .font(.title3)
                    .foregroundStyle(.accent)
                    .bold()
                
                SecureField("Insira sua senha", text: $password)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 14))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                Text("Telefone")
                    .font(.title3)
                    .foregroundStyle(.accent)
                    .bold()
                
                TextField("Insira o seu telefone", text: $phoneNumber)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 14))
                    .keyboardType(.numberPad)
                
                Text("CPF")
                    .font(.title3)
                    .foregroundStyle(.accent)
                    .bold()
                
                TextField("Insira o seu CPF", text: $cpf)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 14))
                    .keyboardType(.numberPad)
                
                Text("Selecione o seu plano de saúde")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.accent)
                
                Picker("Plano de saúde", selection: $healthPlan) {
                    ForEach(healthPlans, id: \.self) { healhPlan in
                        Text(healhPlan)
                    }
                }
                
                Button {
                    //
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
    }
}

#Preview {
    SignUpView()
}
