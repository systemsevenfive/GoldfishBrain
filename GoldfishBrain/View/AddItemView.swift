//
//  AddItemView.swift
//  GoldfishBrain
//
//  Created by Ryan Saunders on 2020-11-29.
//

import SwiftUI

struct AddItemView: View {
    @Environment (\.presentationMode) var presentationMode
    //MARK: - Properties
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
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
                        print("Add a new item")
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
        } // Navigation
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
