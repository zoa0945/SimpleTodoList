//
//  TodoViewModel.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import Foundation
import CoreData

class TodoViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    @Published var todos: [TodoItem] = []
    @Published var allTodos: [TodoItem] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        loadTodos()
        loadAllTodos()
    }
    
    func saveContext() {
        do {
            try context.save()
            loadTodos()
            loadAllTodos()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func toggleTodoCompletion(todo: TodoItem) {
        todo.isCompleted.toggle()
        saveContext()
    }
    
    func addTodo(title: String, date: Date = Date()) {
        let newTodo = TodoItem(context: context)
        newTodo.id = UUID()
        newTodo.title = title
        newTodo.date = date
        newTodo.isCompleted = false
        saveContext()
    }
    
    func loadTodos() {
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else { return }
        
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "(date >= %@) AND (date < %@)", startOfDay as NSDate, endOfDay as NSDate)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TodoItem.date, ascending: true)]
        
        do {
            todos = try context.fetch(request)
        } catch {
            print("Failed to fetch today's todos: \(error)")
        }
    }
    
    func loadAllTodos() {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TodoItem.date, ascending: true)]
        
        do {
            allTodos = try context.fetch(request)
        } catch {
            print("Failed to fetch todos: \(error)")
        }
    }
    
    func deleteTodos(todo: TodoItem) {
        context.delete(todo)
        saveContext()
    }
    
    func updateTodo(todo: TodoItem, newTitle: String, newDate: Date) {
        todo.title = newTitle
        todo.date = newDate
        saveContext()
    }
    
    func getTodo(by id: UUID) -> TodoItem? {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch todo by id: \(error)")
            return nil
        }
    }
}
