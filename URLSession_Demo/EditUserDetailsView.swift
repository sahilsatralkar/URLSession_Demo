//
//  EditUserDetailsView.swift
//  URLSession_Demo
//
//  Created by Sahil Satralkar on 02/05/22.
//

import SwiftUI

struct EditUserDetailsView: View {
    
    @State var name : String
    @State var email : String
    var id : Int
    
    let statusData = [Status.active.rawValue,Status.inactive.rawValue]
    @State private var statusDataSelected = 0
    
    let genderData = [Gender.male.rawValue, Gender.female.rawValue]
    @State private var genderDataSelected = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
       // NavigationView {
            Section {
                List {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    Picker("Gender", selection: $genderDataSelected) {
                        ForEach(0 ..< genderData.count){
                            Text(genderData[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("Status", selection: $statusDataSelected) {
                        ForEach(0 ..< statusData.count) {
                            Text(self.statusData[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Edit User")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        edit()
                    } label: {
                        Text("Save")
                    }
                }
            }
    }
    func edit() {
        //ToDo
        
        
    }
}

struct EditUserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserDetailsView(name: "", email: "", id: 1)
    }
}
