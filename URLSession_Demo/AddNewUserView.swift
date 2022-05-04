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

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
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
                        save()
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
    
    func save() {
        if !self.name.isEmpty && self.email.isValidEmail {
            let newUser = User(name: self.name, email: self.email, gender: self.genderData[genderDataSelected], status: self.statusData[statusDataSelected])
            
        //
            guard let jsonData = try? JSONEncoder().encode(newUser) else {
                print("Error: Unable to convert model data to JSON")
                return
            }
            
            var urlComponents = URLComponents()
            urlComponents.scheme = Constants.scheme
            urlComponents.host = Constants.host
            urlComponents.path = Constants.path
            
            guard let url = urlComponents.url else {
                print("URL is invalid for post request")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            //request.setValue("Authorization", forHTTPHeaderField: Constants.API_Key)
            
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) {
                data, response, error in
                
                
                guard error == nil else {
                    print(error)
                    print("Error: error calling POST")
                    return
                }
                
                guard let data = data else {
                    print("Error did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (000 ..< 10000) ~= response.statusCode else {
                    print("Error: HTTP request failed lksdlakjsd;lak")
                    return
                }
                
                do {
                    guard let jsonResponse = try JSONSerialization.jsonObject(with: data) as? Result else {
                        print("UNable to convert to JSON object")
                        return
                    }
                    
                } catch {
                    print("Error converting to JSON object")
                    return
                }

            }.resume()
            
        }else {
            print("User is invalid")
        }
        self.presentationMode.wrappedValue.dismiss()
        
        
    }
}

struct AddNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUserView()
    }
}
