//  ExerciseDetailView.swift
//  GymPro
//
//  Created by Octavio Serrago on 27/02/2024.
//

import SwiftUI

struct ExerciseDetailView: View {
    @ObservedObject var exercise: Exercise
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingEditSetView = false
    @State private var selectedSet: Sets?
    @State private var sets: [Sets] = []
    @State private var updateToken = UUID()

    var body: some View {
        VStack {
            List {
                ForEach(sets.sorted(by: { ($0.dateCreation ?? Date.distantPast) < ($1.dateCreation ?? Date.distantPast) }), id: \.self) { sets in
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
                    }
                }
                .onDelete(perform: deleteSet)
            }
            .id(updateToken)

            Spacer()
        }
        .navigationBarTitle(Text(exercise.name ?? "Exercise").bold())
        .navigationBarItems(trailing:
            NavigationLink(destination: AddSetsView(exercise: exercise)) {
                Image(systemName: "plus.circle")
            }
        )
        .sheet(isPresented: $showingEditSetView) {
            if let setToEdit = selectedSet {
                EditSetsView(exercise: exercise, set: setToEdit)
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
        .onAppear {
            self.sets = Array(exercise.setsToExercise as? Set<Sets> ?? [])
        }
    }

    func deleteSet(at offsets: IndexSet) {
        withAnimation {
            offsets.map { sets[$0] }.forEach(managedObjectContext.delete)
            do {
                try managedObjectContext.save()
                self.sets = Array(exercise.setsToExercise as? Set<Sets> ?? [])
            } catch {
                print("Error al eliminar la serie: \(error.localizedDescription)")
            }
        }
    }

}
