//
//  ExerciseDetailView.swift
//  GymPro
//
//  Created by Octavio Serrago on 27/02/2024.
//

import SwiftUI

struct ExerciseDetailView: View {
    @ObservedObject var exercise: Exercise

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
                Image(systemName: "plus")
            }
        )
    }
}
