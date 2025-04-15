//
//  AddTodoView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct AddTodoView: View {
    @EnvironmentObject var todayVM: TodayViewModel
    @Environment(\.dismiss) var dismiss
    @State private var newTodoTitle: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("할 일 입력", text: $newTodoTitle)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("할 일 추가")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가") {
                        if !newTodoTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                            todayVM.addTodo(title: newTodoTitle)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTodoView()
}
