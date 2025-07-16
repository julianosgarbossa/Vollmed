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
                    .foregroundColor(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
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
    }
    
    // MARK: - Methods
    private func getSpecialists() async {
        do {
            let result = try await self.service.getAllSpecialists()
            if let result {
                self.specialists = result
            }
        } catch {
            print("Ocorreu um erro ao obter os especialistas: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    HomeView()
}
