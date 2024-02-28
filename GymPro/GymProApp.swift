//
//  GymProApp.swift
//  GymPro
//
//  Created by Octavio Serrago on 26/02/2024.
//

import SwiftUI

@main
struct GymProApp: App {
    @StateObject private var gymProController = GymProController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, gymProController.container.viewContext)
                .environmentObject(gymProController)
            
        }
    }
}
