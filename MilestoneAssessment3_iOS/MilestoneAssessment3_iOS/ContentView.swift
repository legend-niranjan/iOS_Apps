//
//  ContentView.swift
//  MilestoneAssessment3_iOS
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var  viewContext
    @FetchRequest(
        entity: Exercise.entity(),
        sortDescriptors: [])
    private var list : FetchedResults<Exercise>
    @State private var showAddview=false
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(list){ exercise in
                        NavigationLink(destination: EditView(exercise: exercise)){
                            VStack(alignment:  .leading){
                                Text(exercise.execiseName ?? "no name")
                                Text("calory: \(exercise.caloriesBurned, specifier: "%.2f")")
                                Text("duration: \(exercise.duration, specifier: "%.2f")")
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .swipeActions{
                                Button(role: .destructive){
                                    deleteExercise(exercise)
                                } label:{
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .padding()
            .navigationTitle("All Exercise")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        showAddview=true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddview){
                AddView()
            }
        }
    }
        private func deleteExercise(_ exercise: Exercise){
            viewContext.delete(exercise)
            do{
                try viewContext.save()
            }catch{
                print("Error: \(error)")
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
