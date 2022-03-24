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
            LoaderView(content: { geometry in
                NavigationView {
                    //LoginContentView()
                    //BriefingView()
                    //FTUEContentView()
                    SearchPageView()
                }
                .navigationViewStyle(.stack)
                .environmentObject(appEnv)
                .environmentObject(uSettings)
            }, isLoading: $appEnv.isLoading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
