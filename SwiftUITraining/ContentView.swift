//
//  ContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appEnv = AppEnv()
    @StateObject var uSettings = UserSettings()

    var body: some View {
        ToastView(model: $appEnv.toastModel, showingToast: $appEnv.showingToast) {
            NavigationView {
                LoginContentView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(appEnv)
            .environmentObject(uSettings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
