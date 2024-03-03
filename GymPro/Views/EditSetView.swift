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
    
    @State public var sets: Int32
    @State public var weight: Double
    @State public var reps: Int32
    
    @EnvironmentObject var gymProController: GymProController
    
    init(exercise: Exercise, set: Sets, sets: Int32, weight: Double, reps: Int32) {
        self.exercise = exercise
        self.set = set
        _sets = State(initialValue: sets)
        _weight = State(initialValue: weight)
        _reps = State(initialValue: reps)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Set")) {
                    TextField("Sets", value: $sets, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Weight", value: $weight, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    TextField("Reps", value: $reps, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
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
        gymProController.updateSeries(sets: sets, weight: weight, reps: reps, context: managedObjectContext)
        dismiss()
    }
}
