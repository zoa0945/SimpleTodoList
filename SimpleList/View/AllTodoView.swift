//
//  AllTodoView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/15/25.
//

import SwiftUI

struct AllTodoView: View {
    @StateObject private var AllTodoVM = AllTodoViewModel()
    
    private var groupedTodos: [(Date, [TodoItem])] {
        Dictionary(grouping: AllTodoVM.todos) { todo in
            Calendar.current.startOfDay(for: todo.date)
        }
        .map { ($0.key, $0.value) }
        .sorted { $0.0 < $1.0 }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("모든 할 일을 확인 할 수 있습니다.")
                    Spacer()
                }
                .padding()
                
                if groupedTodos.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text("아직 할일이 없어요.")
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
                        ForEach(groupedTodos, id: \.0) { date, todos in
                            Section(header: Text(convertDate(date)).font(.headline)) {
                                ForEach(todos) { todo in
                                    Text(todo.title)
                                        .strikethrough(todo.isCompleted)
                                        .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("전체 보기")
                    .onAppear {
                        AllTodoVM.loadAllTodos()
                    }
                }
            }
        }
    }
    
    func convertDate(_ date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.dateStyle = .long
        return dateformatter.string(from: date)
    }
}

#Preview {
    AllTodoView()
}
