//
//  TabViewController.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 18/07/25.
//

import SwiftUI

struct TabViewController: View {
    
    @AppStorage("token") var token: String = ""
    
    var body: some View {
        
        if token.isEmpty {
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
