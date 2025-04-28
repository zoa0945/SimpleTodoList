//
//  TodoRowView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/28/25.
//

import SwiftUI

struct TodoRowView: View {
    let todo: TodoItem
    let onToggleCompletion: () -> Void
    let onDelete: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggleCompletion) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(Color(todo.isCompleted ? .gray : .label))
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(todo.title ?? "")
                .strikethrough(todo.isCompleted)
                .foregroundStyle(Color(.label))
            
            Spacer()
        }
        .padding(.vertical, 4)
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive, action: onDelete) {
                Label("삭제", systemImage: "trash")
            }
            
            Button(action: onEdit) {
                Label("수정", systemImage: "pencil")
            }
            .tint(.blue)
        }
    }
}
