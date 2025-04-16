//
//  TodoItem.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import Foundation
import RealmSwift

class TodoItem: Object, Identifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var isCompleted: Bool = false
    
    override static func primaryKey() -> String? {
        "id"
    }
}
