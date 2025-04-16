//
//  TodayViewModel.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import Foundation
import RealmSwift

class TodayViewModel: ObservableObject {
    private var realm: Realm
    @Published var todos: [TodoItem] = []
    
    init() {
        realm = try! Realm()
        loadTodos()
    }
    
    func toggleTodoCompletion(id: String) {
        if let item = realm.object(ofType: TodoItem.self, forPrimaryKey: id) {
            try! realm.write {
                item.isCompleted.toggle()
            }
            loadTodos()
        }
    }
    
    func addTodo(title: String) {
        let newTodo = TodoItem()
        newTodo.title = title
        try! realm.write {
            realm.add(newTodo)
        }
        loadTodos()
    }
    
    func loadTodos() {
        let results = realm.objects(TodoItem.self).sorted(byKeyPath: "title", ascending: true)
        todos = Array(results)
    }
    
    func deleteTodos(id: String) {
        if let item = realm.object(ofType: TodoItem.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(item)
            }
            loadTodos()
        }
    }
    
    func updateTodo(id: String, newTitle: String) {
        if let item = realm.object(ofType: TodoItem.self, forPrimaryKey: id) {
            try! realm.write {
                item.title = newTitle
            }
            loadTodos()
        }
    }
}
