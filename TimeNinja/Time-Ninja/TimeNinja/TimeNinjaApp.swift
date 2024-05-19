//
//  TimeNinjaApp.swift
//  TimeNinja!!
//
//  Created by Aziza Rahimova on 19/10/23.
//

import SwiftUI

@main
struct TimeNinjaApp: App {
    @State private var savedNames: [String] = [] // Initialize your data model here if needed
    
    var body: some Scene {
        WindowGroup {
            MainScreenView()
        }
    }
}
