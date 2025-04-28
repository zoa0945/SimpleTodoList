//
//  SimpleListApp.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

@main
struct SimpleListApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var todoVM = TodoViewModel(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(todoVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
