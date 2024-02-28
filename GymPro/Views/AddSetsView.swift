//
//  AddSetsView.swift
//  GymPro
//
//  Created by Octavio Serrago on 27/02/2024.
//

import SwiftUI

struct AddSetsView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var exercise: Exercise
    @State private var sets = ""
    @State private var weight = ""
    @State private var reps = ""

    @EnvironmentObject var gymProController: GymProController // Añade esta línea

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Set")) {
                    TextField("Sets", text: $sets)
                        .keyboardType(.numberPad)
                    TextField("Weight", text: $weight)
                        .keyboardType(.numberPad)
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                }

                Button(action: {
                    saveSet()
                }) {
                    Text("Add Set")
                }
            }
            .navigationBarTitle("Add New Set")
        }
    }
    
    private func saveSet() {
        if let setsValue = Int32(sets), let weightValue = Double(weight), let repsValue = Int32(reps) {
            gymProController.addSeries(sets: setsValue, weight: weightValue, reps: repsValue, to: exercise, context: managedObjContext)
            dismiss()
        } else {
            
        }
    }


}
