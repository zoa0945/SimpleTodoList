//
//  AllTodoView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct AllTodoView: View {
    @EnvironmentObject private var todoVM: TodoViewModel
    @State private var editingTodo: TodoItem?
    
    private var groupedTodos: [(Date, [TodoItem])] {
        Dictionary(grouping: todoVM.allTodos) { todo in
            Calendar.current.startOfDay(for: todo.date ?? Date())
        }
        .map { ($0.key, $0.value) }
        .sorted { $0.0 < $1.0 }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("모든 할 일을 확인 할 수 있습니다.")
                    Spacer()
                }
                .padding()
                .navigationTitle("전체 보기")
                
                if groupedTodos.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text("아직 할일이 없어요.")
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.lightGray))
                        )
                        
                        Spacer()
                    }
                    .padding()
                } else {
                    List {
                        ForEach(groupedTodos, id: \.0) { date, todos in
                            Section(header: Text(convertDate(date)).font(.headline)) {
                                ForEach(todos) { todo in
                                    TodoRowView(todo: todo) {
                                        todoVM.toggleTodoCompletion(todo: todo)
                                    } onDelete: {
                                        todoVM.deleteTodos(todo: todo)
                                    } onEdit: {
                                        editingTodo = todo
                                    }

                                }
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        todoVM.loadAllTodos()
                    }
                }
            }
            .sheet(item: $editingTodo) { todo in
                EditingTodoView(todo: todo)
                    .environmentObject(todoVM)
            }
        }
    }
    
    func convertDate(_ date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.dateStyle = .long
        return dateformatter.string(from: date)
    }
}

#Preview {
    AllTodoView()
}
