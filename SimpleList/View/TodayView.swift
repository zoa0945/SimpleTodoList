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
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 30) {
                    HStack {
                        Text(convertDate())
                        Spacer()
                    }
                    
                    if todayVM.todos.isEmpty {
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
                            ForEach(todayVM.todos) { todo in
                                Button(action: {
                                    todayVM.toggleTodoCompletion(id: todo.id)
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
