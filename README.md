# 🗒️ Todo App (SwiftUI)

SwiftUI로 만든 미니멀하고 실용적인 할 일 관리 앱입니다.  
할 일을 추가하고 완료 상태를 토글하며, 모든 데이터를 로컬에 저장하여 관리할 수 있습니다.

---

## ✨ 주요 기능 진행 현황

- [x] 할 일 추가 및 삭제
- [x] 완료 여부 토글 기능
- [x] UserDefaults를 이용한 데이터 저장
- [x] 4개의 탭 뷰 구성

---

## 🛠️ 사용 기술

- `Swift 5.9`
- `SwiftUI`
- `MVVM` 아키텍처
- ~~`UserDefaults`~~ -> `Realm`으로 변경 (데이터 저장소)

---

## 📂 프로젝트 구조

```
📂 TodoApp
├── Models/
│   └── TodoItem.swift
├── ViewModels/
│   └── TodoViewModel.swift
├── Views/
│   ├── TodayView.swift
│   ├── AddTodoView.swift
│   ├── AllTasksView.swift
│   ├── CalendarView.swift
│   └── SettingsView.swift
└── TodoApp.swift
```

---

## 📌 개선 예정 기능

- [ ] 알림 기능
- [ ] Realm으로 데이터 저장방식 변경
- [ ] iCloud 동기화
- [ ] 배너 광고
- [ ] 다크 모드 최적화

---

## 🧑‍💻 개발자

- **zoa0945**  
  [GitHub](https://github.com/zoa0945)

---

## 🪪 라이선스

MIT License
