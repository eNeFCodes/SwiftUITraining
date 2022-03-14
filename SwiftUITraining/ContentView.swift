//
//  ContentView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/4/22.
//

import SwiftUI

class TestEnv: ObservableObject {
    @Published var stateTest: Bool = false
}

struct ContentView: View {
    @StateObject var testEnv: TestEnv = TestEnv()

    var body: some View {
        NavigationView {
            LoginContentView()
        }
        .navigationViewStyle(.stack)
        .environmentObject(testEnv)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
