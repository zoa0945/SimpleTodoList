//
//  SettingView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("selectedTheme") private var selectedTheme: String = "시스템"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("일반")) {
                    Toggle("알림 받기", isOn: .constant(true))
                    Picker("테마 선택", selection: $selectedTheme) {
                        Text("라이트").tag("라이트")
                        Text("다크").tag("다크")
                        Text("시스템").tag("시스템")
                    }
                }
                
                Section(header: Text("정보")) {
                    HStack {
                        Text("앱 버전")
                        Spacer()
                        Text("1.0.0")
                    }
                    
                    HStack {
                        Text("개발자")
                        Spacer()
                        Text("zoa0945")
                    }
                }
            }
            .navigationTitle("설정")
        }
    }
}

#Preview {
    SettingView()
}
