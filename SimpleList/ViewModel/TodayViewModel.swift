//
//  TodayViewModel.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import Foundation

class TodayViewModel: ObservableObject {
    @Published var todos: [TodoItem] = [] {
        didSet {
            saveTodos()
        }
    }
    
    private let todosKey = "SavedTodos"
    
    init() {
        loadTodos()
    }
    
    func toggleTodoCompletion(id: UUID) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            todos[index].isCompleted.toggle()
            todos = todos
        }
    }
    
    func addTodo(title: String) {
        let newTodo = TodoItem(title: title, isCompleted: false)
        todos.append(newTodo)
    }
    
    func saveTodos() {
        if let encoded = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(encoded, forKey: todosKey)
        }
    }
    
    func loadTodos() {
        if let data = UserDefaults.standard.data(forKey: todosKey),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todos = decoded
        } else {
            todos = [
                TodoItem(title: "운동하기", isCompleted: false),
                TodoItem(title: "공부하기", isCompleted: true),
                TodoItem(title: "장보기", isCompleted: false)
            ]
        }
    }
}
