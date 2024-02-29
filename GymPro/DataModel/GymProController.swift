//
//  GymProController.swift
//  GymPro
//
//  Created by Octavio Serrago on 26/02/2024.
//

import Foundation
import CoreData

class GymProController: ObservableObject {
    let container = NSPersistentContainer(name: "GymPro")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save (context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data save!!")
        } catch {
            print ("Some error going on")
        }
    }
    
    //func day
    
    func addDay (name: String, context: NSManagedObjectContext) {
        let day = Day(context: context)
        day.id = UUID()
        day.name = name
        day.date = Date()
        
        save(context: context)
    }
    
    func editDay (day: Day, name: String, context: NSManagedObjectContext) {
        let day = Day(context: context)
        day.id = UUID()
        day.name = name
        day.date = Date()
        
        save(context: context)
    }
    
    //func exercise
    func addExercise(name: String, context: NSManagedObjectContext, day: Day) {
        let exercise = Exercise(context: context)
        exercise.id = UUID()
        exercise.name = name
        exercise.exerciseToDay = day
        
        save(context: context)
    }
    
    // Add series to exercise
    func addSeries(sets: Int32, weight: Double, reps: Int32, to exercise: Exercise, context: NSManagedObjectContext) {
        let newSet = Sets(context: context)
        newSet.sets = sets
        newSet.weight = weight
        newSet.reps = reps
        newSet.dateCreation = Date()

        exercise.addToSetsToExercise(newSet)

        do {
            try context.save()
        } catch {
        
        }
    }
    
    func updateSeries(set: Sets, sets: Int32, weight: Double, reps: Int32, context: NSManagedObjectContext) {
        print("Iniciando la actualización del set...")
        print("Valores recibidos - Sets: \(sets), Peso: \(weight), Reps: \(reps)")
        
        set.sets = sets
        print("Sets actualizados a \(set.sets)")
        
        set.weight = weight
        print("Peso actualizado a \(set.weight)")
        
        set.reps = reps
        print("Reps actualizados a \(set.reps)")
        
        do {
            try context.save()
            print("El set se ha actualizado y guardado correctamente.")
        } catch {
            print("Error al actualizar el set: \(error)")
        }
    }
    
}
