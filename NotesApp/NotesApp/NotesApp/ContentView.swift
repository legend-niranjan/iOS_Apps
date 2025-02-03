//
//  ContentView.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Notes.entity(),
        sortDescriptors: []
    )
    private var notes: FetchedResults<Notes>
    
    @State private var showAddview = false
    
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(notes){ note in
                        NavigationLink(destination: EditNote(note: note)){
                            
                                VStack(alignment: .leading){
                                    Text(note.title ?? "No title").font(.headline)
                                    Text(note.content ?? "No title").font(.headline).foregroundColor(.gray)
                                    
                                    if let date=note.date{
                                        Text(date.formatted(date: .abbreviated, time: .shortened))
                                            .font(.caption).foregroundColor(.secondary)
                                    }
                                }
                            
                        }.buttonStyle(PlainButtonStyle())
                            .swipeActions{
                                Button(role: .destructive){
                                    deleteNote(note)
                                } label: {
                                    Label("delete", systemImage: "trash")
                                }
                            }
                            
                        
                    }
                }
            }
            .padding()
            .navigationTitle("All Notes")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        showAddview = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddview){AddNoteView()}
        }
    }
    private func deleteNote(_ note: Notes){
        viewContext.delete(note)
        do{
            try viewContext.save()
        }catch{
            print ("Error deleting Note: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
