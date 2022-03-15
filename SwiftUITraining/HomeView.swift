//
//  HomeView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/14/22.
//

import SwiftUI

struct Tab1: View {
    @State var name: String
    var body: some View {
        Text("\(name) Tab")
    }

}

struct HomeView: View {
    @EnvironmentObject private var appEnv: AppEnv
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        TabView {
            Tab1(name: "Favorites")
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
                .badge(50)
            Tab1(name: "Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            Tab1(name: "Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home View")
        .navigationBarItems(trailing: Button("Logout") {
            appEnv.isLoggedIn = false
            appEnv.loginType = .default
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
