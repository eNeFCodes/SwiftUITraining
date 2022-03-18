//
//  HomeView.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/14/22.
//

import SwiftUI

struct Tab1: View {
    enum PickerOptions: Hashable, CaseIterable {
        case test1
        case test2
    }

    @State var pickerSelection: PickerOptions = .test1
    @State var name: String

    var body: some View {
        Text("\(name) Tab")

//        Picker("Test Picker", selection: $pickerSelection) {
//            Text("A").tag(PickerOptions.test1)
//            Text("B").tag(PickerOptions.test2)
//        }
//        .onSubmit {
//            print("pickerSelection: ", pickerSelection)
//        }
    }
}

struct HomeView: View {
    @EnvironmentObject private var appEnv: AppEnv
    @Environment(\.presentationMode) var presentationMode

    @State var selectColor: Color = .red

    var body: some View {
        TabView {
            Text("Favorites")
                .redacted(reason: .placeholder)
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
            ColorPicker("Color Profile", selection: $selectColor)
                .padding(20)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home View")
        .navigationBarItems(trailing: Button("Logout") {
            appEnv.isLoggedIn = false
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
