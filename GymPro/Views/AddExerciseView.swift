//
//  AddExerciseView.swift
//  GymPro
//
//  Created by Octavio Serrago on 27/02/2024.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    
    var day: Day
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Name")) {
                    TextField("Exercise Name", text: $name)
                        .padding()
                }
            }
            .navigationBarTitle("Add Exercise")
            .navigationBarItems(trailing: Button("Save", action: {
                saveExercise()
                dismiss()
            }))
        }
    }
    
    private func saveExercise() {
        let gymProController = GymProController()
        gymProController.addExercise(name: name, context: managedObjContext, day: day)
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(day: Day())
    }
}
