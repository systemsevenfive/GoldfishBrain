//
//  ContentView.swift
//  GoldfishBrain
//
//  Created by Ryan Saunders on 2020-11-29.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    
    @Environment (\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: ToDoItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.name, ascending: true)]) var ToDoItems: FetchedResults<ToDoItem>
    @State private var showingAddItemView: Bool = false
    
    
    //MARK: Body
    var body: some View {
        NavigationView {
            List {
                ForEach(self.ToDoItems, id: \.self) { toDoItem in
                    HStack {
                        Text(toDoItem.name ?? "Unknown")
                        Spacer()
                        Text(toDoItem.priority ?? "Unknown")
                    }
                }// ForEach
                .onDelete(perform: deleteToDoItem)
            }// List
            .navigationBarTitle("Stuff to do", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddItemView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }//: Add button
                    .sheet(isPresented: $showingAddItemView) {
                        AddItemView().environment(\.managedObjectContext, self.managedObjectContext)
                    }
            )
        }//: Navigation
    }
    private func deleteToDoItem(at offsets: IndexSet) {
        for index in offsets {
            let toDoItem = ToDoItems[index]
            managedObjectContext.delete(toDoItem)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as!
                        AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
            .previewDevice("iPhone 11 Pro Max")
    }
}
