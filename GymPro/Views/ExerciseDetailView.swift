//  ExerciseDetailView.swift
//  GymPro
//
//  Created by Octavio Serrago on 27/02/2024.
//

import SwiftUI
import CoreData

struct ExerciseDetailView: View {
    @ObservedObject var exercise: Exercise
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingEditSetView = false
    @State private var selectedSet: Sets?

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(Array(exercise.setsToExercise as? Set<Sets> ?? []).sorted(by: { ($0.dateCreation ?? Date.distantPast) < ($1.dateCreation ?? Date.distantPast) }), id: \.self) { sets in
                    HStack {
                        Text("\(sets.sets) sets")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("\(String(format: "%.1f", sets.weight)) kg")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(sets.reps) reps")
                            .font(.body)
                            .foregroundColor(.green)

                        Spacer()

                        Button(action: {
                            self.selectedSet = sets
                            self.showingEditSetView = true
                        }) {
                            Image(systemName: "pencil")
                        }
                        .buttonStyle(BorderlessButtonStyle())

                        Button(action: {
                            self.deleteSet(set: sets)
                        }) {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle(Text(exercise.name ?? "Exercise").bold())
        .navigationBarItems(trailing:
            NavigationLink(destination: AddSetsView(exercise: exercise)) {
                Image(systemName: "plus.circle")
            }
        )
        .sheet(item: $selectedSet) { setToEdit in
            EditSetsView(exercise: exercise, set: setToEdit, sets: setToEdit.sets, weight: setToEdit.weight, reps: setToEdit.reps)
                .environment(\.managedObjectContext, self.managedObjectContext)
        }


    }

    func deleteSet(set: Sets) {
        // Asegúrate de que el conjunto de series contiene la serie a eliminar
        guard let sets = self.exercise.setsToExercise as? Set<Sets>, sets.contains(set) else {
            return
        }
        
        self.exercise.removeFromSetsToExercise(set)
        self.managedObjectContext.delete(set)
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error al guardar cambios: \(error.localizedDescription)")
        }
    }

}
