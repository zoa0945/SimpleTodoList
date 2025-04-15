//
//  TodayView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct TodayView: View {
    @StateObject var todoVM = TodoViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                HStack {
                    Text(convertDate())
                    Spacer()
                }
                
                if todoVM.todos.isEmpty {
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
                } else {
                    List {
                        ForEach(todoVM.todos) { todo in
                            Button(action: {
                                todoVM.toggleTodoCompletion(id: todo.id)
                            }) {
                                HStack {
                                    Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(Color(.gray))
                                    Text(todo.title)
                                        .strikethrough(todo.isCompleted)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listRowInsets(EdgeInsets())
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("오늘 할 일")
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
