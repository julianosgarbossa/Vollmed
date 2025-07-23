//
//  TabViewController.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 18/07/25.
//

import SwiftUI

struct TabViewController: View {
    
    @ObservedObject private var authManager = AuthenticationManager.shared
    
    var body: some View {
        
        if authManager.token == nil {
            SignInView()
        } else {
            TabView {
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
            }
        }
    }
}

#Preview {
    TabViewController()
}
