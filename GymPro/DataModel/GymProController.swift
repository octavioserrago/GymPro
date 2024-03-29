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
    
    
    
    // Agregar una serie a un ejercicio dentro de un día
    func addSeries(sets: Int32, weight: Double, reps: Int32, to exercise: Exercise, in day: Day, context: NSManagedObjectContext) {
        
        let series = Sets(context: context)
        series.id = UUID()
        series.weight = weight
        series.reps = reps
        series.sets = sets
        series.dateCreation = Date()
        
       
        exercise.addToSetsToExercise(series)
        
   
        exercise.exerciseToDay = day
        
        
        saveChanges(context: context)
    }


    // Función para guardar los cambios en el contexto
    func saveChanges(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error al guardar los cambios en el contexto: \(error)")
        }
    }

    
    func updateSeries(setToUpdate: Sets, sets: Int32, weight: Double, reps: Int32, context: NSManagedObjectContext) {
        setToUpdate.sets = sets
        setToUpdate.weight = weight
        setToUpdate.reps = reps
        save(context: context)
    }

    
}
