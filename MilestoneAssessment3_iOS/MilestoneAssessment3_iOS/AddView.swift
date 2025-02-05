//
//  AddView.swift
//  MilestoneAssessment3_iOS
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var duration=""
    @State private var name=""
    @State private var coloriesBurned=""
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Exercize")){
                    TextField("Enter name: ", text: $name)
                    TextField("Enter colories: ", text: $coloriesBurned)
                    TextField("Enter duration: ", text: $duration)
                }
            }.navigationBarTitle("Add")
                .navigationBarItems(leading: Button("cancel"){
                    dismiss()
                }, trailing: Button("save"){
                    add()
                    dismiss()
                }.disabled(name.isEmpty))
        }
       
    }
    private func add(){
        let exercise = Exercise(context: viewContext)
        
        if let isdouble=Double(coloriesBurned){
            exercise.caloriesBurned=isdouble
        }else{
            exercise.caloriesBurned=0.0
        }
        if let isdouble=Double(duration){
            exercise.duration=isdouble
        }else{
            exercise.duration=0.0
        }
    
        exercise.execiseName=name
        do{
            try viewContext.save()
        }catch{
            print("Error: \(error)")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
