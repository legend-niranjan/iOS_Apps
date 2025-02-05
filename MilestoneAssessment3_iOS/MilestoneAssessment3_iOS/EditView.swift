//
//  AddView.swift
//  MilestoneAssessment3_iOS
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var exercise: Exercise
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
            }.navigationBarTitle("Edit")
                .navigationBarItems(leading: Button("cancel"){
                    dismiss()
                }, trailing: Button("save"){
                    add()
                    dismiss()
                }.disabled(name.isEmpty))
                .onAppear{
                    name=exercise.execiseName ?? ""
                    coloriesBurned = String(format: "%.2f", exercise.caloriesBurned)
                    duration = String(format: "%.2f", exercise.duration)
                }
        }
       
    }
    private func add(){
        exercise.execiseName=name
        do{
            try viewContext.save()
        }catch{
            print("Error: \(error)")
        }
       
    }
}


