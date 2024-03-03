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
    @FetchRequest(entity: Sets.entity(), sortDescriptors: []) var sets: FetchedResults<Sets>

    @State private var selectedSet: Sets?

    var body: some View {
        VStack {
            List {
                ForEach(sets, id: \.self) { set in
                    NavigationLink(destination: EditSetsView(exercise: exercise, set: set, sets: set.sets, weight: set.weight, reps: set.reps)) {
                        SetRow(set: set)
                    }
                }
                .onDelete(perform: deleteSet)
            }
            Spacer()
        }
        .navigationBarTitle(Text(exercise.name ?? "Exercise").bold())
        .navigationBarItems(trailing:
            NavigationLink(destination: AddSetsView(exercise: exercise)) {
                Image(systemName: "plus.circle")
            }
        )
    }

    private func deleteSet(at offsets: IndexSet) {
        offsets.forEach { index in
            let set = sets[index]
            managedObjectContext.delete(set)
        }

        do {
            try managedObjectContext.save()
        } catch {
            print("Error deleting sets: \(error)")
        }
    }
}

struct SetRow: View {
    var set: Sets

    var body: some View {
        HStack {
            Text("\(set.sets) sets")
                .font(.headline)
                .foregroundColor(.blue)
            Text("\(String(format: "%.1f", set.weight)) kg")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(set.reps) reps")
                .font(.body)
                .foregroundColor(.green)
        }
    }
}
