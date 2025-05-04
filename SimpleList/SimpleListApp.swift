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
    @AppStorage("selectedTheme") private var selectedTheme: String = "시스템"
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(themeScheme(for: selectedTheme))
                .environmentObject(todoVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    private func themeScheme(for selection: String) -> ColorScheme? {
        switch selection {
        case "라이트":
            return .light
        case "다크":
            return .dark
        default:
            return nil
        }
    }
}
