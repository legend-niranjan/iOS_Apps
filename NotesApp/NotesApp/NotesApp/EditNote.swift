//
//  EditNote.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct EditNote: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var note : Notes
    @State private var content=""
    @State private var title=""
    @State private var selectDate = Date()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Edit Note")){
                    TextField("Enter title", text: $title)
                    TextField("Enter content", text: $content)
                }
                Section(header: Text("Edit date")){
                    DatePicker("Select date", selection: $selectDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
                .navigationBarTitle("Edit Note", displayMode: .inline)
                .navigationBarItems(leading: Button("Cancle"){
                    dismiss()
                }, trailing: Button("Edit"){
                    note.content=content
                    note.title=title
                    note.date=selectDate
                    editnote()
                    dismiss()
                }.disabled(title.isEmpty || content.isEmpty))
                .onAppear{
                    title=note.title ?? ""
                    content=note.content ?? ""
                    selectDate=note.date ?? Date()
                }
            }
        }
    }
    private func editnote(){

        do{
            try viewContext.save()
        }catch{
            print("Error: \(error)")
        }
    }
}


