//
//  TaskAddView.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var task: Task
    @State private var title=""
    @State private var category=""
    @State private var isCompleted=false
    @State private var dueDate=Date()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Add task")){
                    TextField("Enter title: ", text: $title)
                    TextField("Enter category: ", text: $category)
                    Toggle("Is Completed", isOn: $isCompleted)
                    DatePicker("select date", selection: $dueDate, displayedComponents: .date).datePickerStyle(.graphical)
                }
            }.navigationBarTitle("Edit Task", displayMode: .inline)
                .navigationBarItems(leading: Button("cancle"){
                    dismiss()
                }, trailing: Button("Edit"){
                    task.isCompleted=isCompleted
                    task.dueDate=dueDate
                    task.category=category
                    task.title=title
                    editTask()
                    dismiss()
                }).disabled(title.isEmpty || category.isEmpty)
                .onAppear{
                    title=task.title ?? ""
                    category=task.category ?? ""
                    dueDate=task.dueDate ?? Date()
                    isCompleted=task.isCompleted
                }
        }
    }
    private func editTask(){
        
        do{
            try viewContext.save()
        }catch{
            print("Error to add: \(error)")
        }
        
    }
}

