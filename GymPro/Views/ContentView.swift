//
//  ContentView.swift
//  GymPro
//
//  Created by Octavio Serrago on 26/02/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .forward)]) var day: FetchedResults<Day>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(day) { day in
                        NavigationLink(destination: Text("\(day.name ?? "")")) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(day.name ?? "")
                                        .bold()
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteDay)
                }
            }
            .navigationBarTitle("Gym Pro", displayMode: .large) // Agrega el título aquí
            .navigationBarItems(trailing: Button(action: {
                // Action to navigate to AddDayView
                showingAddView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddView) {
                // Present AddDayView here
                AddDayView()
            }
        }
    }
}

// Define your AddDayView here

private func deleteDay(offsets: IndexSet) {
    // Implement deletion logic
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
