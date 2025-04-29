//
//  CalendarView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var todoVM: TodoViewModel
    @State private var seletedDate: Date = Date()
    @State private var editingTodo: TodoItem?
    
    var todosForSelectedDate: [TodoItem] {
        todoVM.allTodos.filter {
            Calendar.current.isDate($0.date ?? Date(), inSameDayAs: seletedDate)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "날짜 선택",
                    selection: $seletedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .environment(\.locale, Locale(identifier: "ko-KR"))
                .padding()
                
                if todosForSelectedDate.isEmpty {
                    Spacer()
                    
                    Text("할 일이 없습니다.")
                        .foregroundStyle(Color(.gray))
                    
                    Spacer()
                } else {
                    List {
                        ForEach(todosForSelectedDate) { todo in
                            TodoRowView(todo: todo) {
                                todoVM.toggleTodoCompletion(todo: todo)
                            } onDelete: {
                                todoVM.deleteTodos(todo: todo)
                            } onEdit: {
                                editingTodo = todo
                            }

                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("캘린더")
        }
        .sheet(item: $editingTodo) { todo in
            EditingTodoView(todo: todo)
                .environmentObject(todoVM)
        }
    }
}

#Preview {
    CalendarView()
}
