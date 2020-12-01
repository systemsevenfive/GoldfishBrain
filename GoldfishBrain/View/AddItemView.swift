//
//  AddItemView.swift
//  GoldfishBrain
//
//  Created by Ryan Saunders on 2020-11-29.
//

import SwiftUI

struct AddItemView: View {
    @Environment (\.presentationMode) var presentationMode
    @Environment (\.managedObjectContext) var managedObjectContext
    //MARK: - Properties
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let priorities = ["High", "Normal", "Low"]
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //MSRK: - Item name
                    TextField("What is it?", text: $name)
                    
                    //MARK: Todo Priority
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Button(action: {
                        if self.name != "" {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.name = self.name
                            toDoItem.priority = self.priority
                            
                            do {
                                try self.managedObjectContext.save()
                                print("New to do item: \(toDoItem.name ?? ""), Priority: \(toDoItem.name ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for the \n new to-do item"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Save")
                    }// SAVE button
                } // Form
                Spacer()
            } // VStack
            .navigationBarTitle("What Shouldn't We Forget?", displayMode: .inline)
            .navigationBarItems(leading:
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "xmark")
                                }
            )
            .alert(isPresented: $errorShowing, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("ok")))
            })
        } // Navigation
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
