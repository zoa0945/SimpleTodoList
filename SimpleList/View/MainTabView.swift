//
//  MainTabView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("defaultView") private var defaultView: String = "오늘"
    @State private var selectedTab: Int = 0
    
    init(defaultView: String) {
        switch defaultView {
        case "전체":
            _selectedTab = State(initialValue: 1)
        case "캘린더":
            _selectedTab = State(initialValue: 2)
        default:
            _selectedTab = State(initialValue: 0)
        }
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                TodayView()
                    .tabItem {
                        Label("오늘", systemImage: "calendar")
                    }
                    .tag(0)
                
                AllTodoView()
                    .tabItem {
                        Label("전체 보기", systemImage: "list.bullet")
                    }
                    .tag(1)
                
                CalendarView()
                    .tabItem {
                        Label("일정", systemImage: "calendar.circle")
                    }
                    .tag(2)
                
                SettingView()
                    .tabItem {
                        Label("설정", systemImage: "gear")
                    }
            }
            
            BannerAdView(adUnitID: "ca-app-pub-3940256099942544/2934735716")
                .frame(height: 50)
        }
    }
}
