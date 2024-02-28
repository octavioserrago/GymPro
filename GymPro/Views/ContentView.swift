//
//  ContentView.swift
//  GymPro
//
//  Created by Octavio Serrago on 26/02/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .forward)]) private var days: FetchedResults<Day>
    @State private var showingAddView = false
    
    @EnvironmentObject var gymProController: GymProController 

    var body: some View {
        NavigationView {
            List {
                ForEach(days) { day in
                    NavigationLink(destination: DayDetailView(day: day)) {
                        Text(day.name ?? "")
                            .bold()
                    }
                }
                .onDelete(perform: deleteDays)
            }
            .navigationBarTitle("Gym Copilot")
            .navigationBarItems(trailing: Button(action: {
                showingAddView.toggle()
            }) {
                Image(systemName: "plus")
                    .padding()
            })
            .sheet(isPresented: $showingAddView) {
                AddDayView().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }

    private func deleteDays(at offsets: IndexSet) {
        for index in offsets {
            let day = days[index]
            managedObjectContext.delete(day)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Error deleting day: \(error)")
        }
    }
}

struct DayDetailView: View {
    @ObservedObject var day: Day
    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.creationDate, ascending: false)]) var exercises: FetchedResults<Exercise>
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State private var showingAddExerciseView = false

    var body: some View {
        VStack {
            List {
                ForEach(exercises.filter { $0.exerciseToDay == day }) { exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                        HStack {
                            Text(exercise.name ?? "")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: deleteExercise)
            }
        }
        .navigationBarTitle(Text(day.name ?? "").font(.largeTitle).bold())
        .navigationBarItems(trailing: Button(action: {
            showingAddExerciseView.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.title)
                .foregroundColor(.accentColor)
        })
        .sheet(isPresented: $showingAddExerciseView) {
            AddExerciseView(day: day)
        }
    }

    private func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let exercise = exercises[index]
            managedObjectContext.delete(exercise)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Error deleting exercise: \(error)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
