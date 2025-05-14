//
//  SimpleListApp.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI
import GoogleMobileAds

@main
struct SimpleListApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var todoVM = TodoViewModel(context: PersistenceController.shared.container.viewContext)
    @AppStorage("selectedTheme") private var selectedTheme: String = "시스템"
    @AppStorage("defaultView") private var defaultView: String = "오늘"
    
    init() {
        MobileAds.shared.start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(defaultView: defaultView)
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
