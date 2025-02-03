//
//  ContentView.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: []
    )
    private var tasks: FetchedResults<Task>
    @State private var showAddView=false
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(tasks){ task in
                        NavigationLink(destination: TaskEditView(task : task)){
                            VStack(alignment: .leading){
                                Text(task.title ?? "No title").font(.headline).foregroundColor(.black)
                                Text(task.category ?? "No category").font(.headline).foregroundColor(.black)
                                if let date=task.dueDate{
                                    Text(date.formatted(date: .abbreviated , time: .shortened))
                                        .font(.subheadline).foregroundColor(.black)
                                }
                                if let status=task.isCompleted ? "Task Completed" : "Incomplete"{
                                    Text(status).bold().foregroundColor(task.isCompleted ? .green: .red)
                                }
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .swipeActions{
                                Button(role: .destructive){
                                    delete(task)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    
                    }
                    
                }
               
            }
            .padding()
            .navigationTitle("All tasks")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showAddView=true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView){TaskAddView()}
        }
    }
    private func delete(_ task:Task){
        viewContext.delete(task)
        do{
            try viewContext.save()
        }catch{
            print("Error to delete: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
