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
    @State private var showingAddItemView: Bool = false
    
    
    //MARK: Body
    var body: some View {
        NavigationView {
            List(0..<5) { item in
                Text("Hello, world!")
            }// List
            .navigationBarTitle("Stuff to do", displayMode: .inline)
            .navigationBarItems(trailing:
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
