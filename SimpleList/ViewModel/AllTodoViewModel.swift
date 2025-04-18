//
//  AllTodoViewModel.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/18/25.
//

import Foundation
import RealmSwift

class AllTodoViewModel: ObservableObject {
    private var realm: Realm
    @Published var todos: [TodoItem] = []
    
    init() {
        realm = try! Realm()
        loadAllTodos()
    }
    
    func loadAllTodos() {
        let result = realm.objects(TodoItem.self)
            .sorted(byKeyPath: "date", ascending: true)
        todos = Array(result)
    }
}
