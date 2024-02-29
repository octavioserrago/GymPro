//  EditSetsView.swift
//  GymPro
//
//  Created by Octavio Serrago on 27/02/2024.
//

import SwiftUI

struct EditSetsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var exercise: Exercise
    @ObservedObject var set: Sets
    
    @State private var sets = ""
    @State private var weight = ""
    @State private var reps = ""
    
    @EnvironmentObject var gymProController: GymProController
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Set")) {
                    TextField("Sets", text: $sets)
                        .keyboardType(.numberPad)
                        .onAppear {
                            sets = String(set.sets)
                        }
                    TextField("Weight", text: $weight)
                        .keyboardType(.numberPad)
                        .onAppear {
                            weight = String(format: "%.1f", set.weight)
                        }
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                        .onAppear {
                            reps = String(set.reps)
                        }
                }
                
                Button(action: {
                    updateSet()
                }) {
                    Text("Save Changes")
                }
            }
            .navigationBarTitle("Edit Set")
        }
    }
    
    private func updateSet() {
        if let setsValue = Int32(sets), let weightValue = Double(weight), let repsValue = Int32(reps) {
            gymProController.updateSeries(set: set, sets: setsValue, weight: weightValue, reps: repsValue, context: managedObjectContext)
            dismiss()
        } else {
    
        }
    }
}

