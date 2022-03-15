//
//  SwiftUITrainingApp.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/4/22.
//

import SwiftUI

@main
struct SwiftUITrainingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    logFonts()
                }
        }
    }
}

func logFonts() {
    if let fancy = UIFont(name: "FancyCutCondProB7-Bold", size: 20) {
        print("Fancy: ", fancy.familyName)
    }

}
