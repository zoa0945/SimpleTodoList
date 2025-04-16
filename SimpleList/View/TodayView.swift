//
//  TodayView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct TodayView: View {
    @StateObject var todayVM = TodayViewModel()
    @State private var showingAddTodo = false
    @State private var editingTodo: TodoItem?
    @State private var newTitle: String = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 30) {
                    HStack {
                        Text(convertDate())
                        Spacer()
                    }
                    
                    if todayVM.todos.isEmpty {
                        VStack {
                            HStack {
                                Spacer()
                                
                                Text("오늘 할 일이 없습니다.")
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
                    } else {
                        List {
                            ForEach(todayVM.todos) { todo in
                                Button(action: {
                                    todayVM.toggleTodoCompletion(id: todo.id)
                                }) {
                                    HStack {
                                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundStyle(Color(.gray))
                                        
                                        Text(todo.title)
                                            .strikethrough(todo.isCompleted)
                                        
                                        Spacer()
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .listRowInsets(EdgeInsets())
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive, action: {
                                        todayVM.deleteTodos(id: todo.id)
                                    }) {
                                        Label("삭제", systemImage: "trash")
                                    }
                                    
                                    Button(action: {
                                        editingTodo = todo
                                        newTitle = todo.title
                                    }) {
                                        Label("수정", systemImage: "pencil")
                                    }
                                    .tint(.blue)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .padding()
                .navigationTitle("오늘 할 일")
                
                Button(action: {
                    showingAddTodo = true
                }) {
                    Image(systemName: "plus")
                        .foregroundStyle(Color(.white))
                        .padding()
                        .background(Color(.gray))
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingAddTodo) {
            AddTodoView()
                .environmentObject(todayVM)
        }
        .alert("할 일 수정", isPresented: Binding(get: {
            editingTodo != nil
        }, set: { newValue in
            if !newValue { editingTodo = nil }
        })) {
            TextField("수정할 내용", text: $newTitle)
            Button("저장", action: {
                if let todo = editingTodo {
                    todayVM.updateTodo(id: todo.id, newTitle: newTitle)
                    editingTodo = nil
                }
            })
            Button("취소", role: .cancel) {
                editingTodo = nil
            }
        } message: {
            Text("할 일을 수정합니다.")
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

#Preview {
    TodayView()
}
