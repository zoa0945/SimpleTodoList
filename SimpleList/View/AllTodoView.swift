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
    @State private var showingAddTodo: Bool = false
    
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
                if groupedTodos.isEmpty {
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
                
                Spacer()
            }
            .navigationTitle("할일 전체 보기")
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
        .sheet(item: $editingTodo) { todo in
            EditingTodoView(todo: todo)
                .environmentObject(todoVM)
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
