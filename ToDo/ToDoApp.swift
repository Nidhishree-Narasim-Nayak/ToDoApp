//
//  ToDoApp.swift
//  ToDo
//
//  Created by Nidhishree Nayak on 03/07/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ToDo.self)
    }
}

@Model class ToDo {
    var title: String
    var isCompleted: Bool
    
    init(
        title: String,
        isCompleted: Bool
    ) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

extension Bool: @retroactive Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        !lhs && rhs
    }
}
