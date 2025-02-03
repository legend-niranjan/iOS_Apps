//
//  TaskAddView.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct TaskAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
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
            }.navigationBarTitle("Add new Task", displayMode: .inline)
                .navigationBarItems(leading: Button("cancle"){
                    dismiss()
                }, trailing: Button("save"){
                    addtask()
                    dismiss()
                }.disabled(title.isEmpty || category.isEmpty))
                
        }
    }
    private func addtask(){
        let task=Task(context: viewContext)
        task.title=title
        task.category=category
        task.isCompleted=isCompleted
        task.dueDate=dueDate
        
        do{
            try viewContext.save()
        }catch{
            print("Error to add: \(error)")
        }
        
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddView()
    }
}
