//
//  MainTabView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("오늘", systemImage: "calendar")
                }
            
            AllTaskView()
                .tabItem {
                    Label("전체 보기", systemImage: "list.bullet")
                }
            
            CalendarView()
                .tabItem {
                    Label("일정", systemImage: "calendar.circle")
                }
            
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainTabView()
}
