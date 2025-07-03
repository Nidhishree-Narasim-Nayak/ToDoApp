//
//  ContentView.swift
//  ToDo
//
//  Created by Nidhishree Nayak on 03/07/25.
//

import SwiftUI
import SwiftData

/// List - Lots of items we can scroll through the list.
/// Delete function - To Delete Items.
/// Alert - User can add to do items.
/// Tootlbar - to add to do items.
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ToDo.isCompleted) private var toDos: [ToDo]
    
    @State private var isAlertShowing = false
    @State private var toDoTitle = ""
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) { toDo in
                    HStack {

                        Button {
                            toDo.isCompleted.toggle()
                        } label: {
                            Image(systemName: toDo.isCompleted ? "checkmark.circle.fill": "circle")
                        }
                        Text(toDo.title)
                    }
                }
                .onDelete(perform: deleteToDos(_:))
            }
//            .background {
//                if toDos.isEmpty {
//                    ContentUnavailableView("Nothing to do here", systemImage: "checkmark.circle.fill")
//                }
//            }
            .navigationTitle("ToDo App")
            .toolbar {
                Button {
                    isAlertShowing.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }

            }
            .alert("Add ToDo Items", isPresented: $isAlertShowing) {
                TextField("Enter ToDo Items", text: $toDoTitle)
                Button {
                    modelContext.insert(ToDo(title: toDoTitle, isCompleted: false))
                } label: {
                    Text("Add")
                }
            }
            .overlay {
                if toDos.isEmpty {
                    ContentUnavailableView("No Items Available", systemImage: "checkmark.circle.fill")
                }
            }
        }
    }
    
    /// method to delete the to do list
    /// - Parameter _indexSet: _indexSet removes the certified model from the persistent storage
    func deleteToDos(_ indexSet: IndexSet) {
        for index in indexSet {
            let toDo = toDos[index]
            modelContext.delete(toDo)
        }
    }
}

#Preview {
    ContentView()
}
