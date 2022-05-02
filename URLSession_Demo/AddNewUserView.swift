//
//  AddNewUserView.swift
//  URLSession_Demo
//
//  Created by Sahil Satralkar on 02/05/22.
//

import SwiftUI

enum Gender : String, CaseIterable {
    case male = "male"
    case female = "female"
}

enum Status : String, CaseIterable {
    case active = "active"
    case inactive = "inactive"
}

struct AddNewUserView: View {
    @State var name : String = ""
    @State var email : String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    let statusData = [Status.active.rawValue,Status.inactive.rawValue]
    @State private var statusDataSelected = 0
    
    let genderData = [Gender.male.rawValue, Gender.female.rawValue]
    @State private var genderDataSelected = 0
    
    var body: some View {
        NavigationView{
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
            .navigationTitle("Add New User")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        //toDo
                    } label: {
                        Text("Save")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
            }
        }
    }
}

struct AddNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUserView()
    }
}
