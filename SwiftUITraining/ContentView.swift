//
//  ContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appEnv: AppEnv = AppEnv()

    var body: some View {
        NavigationView {
            LoginContentView()
        }
        .navigationViewStyle(.stack)
        .environmentObject(appEnv)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
