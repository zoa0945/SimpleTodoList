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
    
    func addTodo(title: String, date: Date = Date()) {
        let newTodo = TodoItem()
        newTodo.title = title
        newTodo.date = date
        try! realm.write {
            realm.add(newTodo)
        }
        loadTodos()
    }
    
    func loadTodos() {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko-KR")
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else { return }
        let results = realm.objects(TodoItem.self)
            .filter("date >= %@ AND date < %@", startOfDay, endOfDay)
            .sorted(byKeyPath: "date", ascending: true)
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
