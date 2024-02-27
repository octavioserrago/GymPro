//
//  AddDayView.swift
//  GymPro
//
//  Created by Octavio Serrago on 26/02/2024.
//

import SwiftUI

struct AddDayView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    
    var body: some View {
        Form {
            Section {
                TextField("New training Day Name", text: $name)
                    .padding()
                HStack{
                    Spacer()
                    Button("Save"){
                        GymProController().addDay(name: name, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}


struct AddDayView_Previews: PreviewProvider {
    static var previews: some View {
        AddDayView()
    }
}
