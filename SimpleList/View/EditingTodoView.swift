//
//  EditingTodoView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/18/25.
//

import SwiftUI

struct EditingTodoView: View {
    @EnvironmentObject var todoVM: TodoViewModel
    @Environment(\.dismiss) var dismiss
    
    
    
    @State private var editedTitle: String
    @State private var editedDate: Date
    
    var todo: TodoItem
    
    init(todo: TodoItem)  {
        self.todo = todo
        _editedTitle = State(initialValue: todo.title ?? "")
        _editedDate = State(initialValue: todo.date ?? Date())
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("할 일 수정", text: $editedTitle)
                DatePicker("날짜 수정", selection: $editedDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
            }
            .navigationTitle("할 일 수정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        todoVM.updateTodo(todo: todo, newTitle: editedTitle, newDate: editedDate)
                        dismiss()
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
