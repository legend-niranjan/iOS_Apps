//
//  AddNoteView.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var content=""
    @State private var title=""
    @State private var selectDate = Date()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Add note")){
                    TextField("Enter title", text: $title)
                    TextField("Enter content", text: $content)
                   
                }
                Section(header: Text("Note date")){
                    DatePicker("Select date", selection: $selectDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
            }.navigationBarTitle("Add new Note", displayMode : .inline)
                .navigationBarItems(leading: Button("cancel"){
                    dismiss()
                },trailing: Button("Save"){
                    addNotes()
                    dismiss()
                }
                    .disabled(title.isEmpty || content.isEmpty))
        }
    }
    private func addNotes(){
        let notes = Notes(context: viewContext)
        
        notes.title=title
        notes.content=content
        notes.date=selectDate
        
        do{
            try viewContext.save()
        }catch{
            print("Error in saving \(error)")
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
