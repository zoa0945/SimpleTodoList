//
//  TodayView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var todoVM: TodoViewModel
    @State private var showingAddTodo = false
    @State private var editingTodo: TodoItem?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Text(convertDate())
                    Spacer()
                }
                .padding()
                
                if todoVM.todos.isEmpty {
                    HStack {
                        Spacer()
                        
                        Text("오늘 할 일이 없습니다.")
                            .foregroundColor(.gray)
                            .padding()
                        
                        Spacer()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.lightGray))
                    )
                    .padding()
                } else {
                    List {
                        ForEach(todoVM.todos) { todo in
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
                Spacer()
            }
            .navigationTitle("오늘 할 일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddTodo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddTodo) {
            AddTodoView()
                .environmentObject(todoVM)
        }
        .sheet(item: $editingTodo, onDismiss: {
            editingTodo = nil
            todoVM.loadTodos()
        }) { todo in
            EditingTodoView(todo: todo)
                .environmentObject(todoVM)
        }
    }
}

func convertDate() -> String {
    let today = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko-KR")
    dateFormatter.dateFormat = "yyyy년 MM월 dd일 EEEE"
    return dateFormatter.string(from: today)
}
