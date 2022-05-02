//
//  ContentView.swift
//  URLSession_Demo
//
//  Created by Sahil Satralkar on 23/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = [Result]()
    
    @State private var showAddUser : Bool = false
    
    var body: some View {
        NavigationView {
            List {
                //Add for each
                ForEach(results, id: \.name ){ result in
                    
                    
                    
                    
                    NavigationLink(destination: EditUserDetailsView(user: result))
                    {
                        VStack (alignment : .leading) {
                            Text (result.name)
                                .font(.headline)
                            Text(String(result.id))
                            Text(result.email)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .task {
                await loadData()
            }
            
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddUser.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .sheet(isPresented: $showAddUser) {
                AddNewUserView()
            }
            .navigationBarTitle("Results")
        }
        
        
    }
    func delete(at offsets: IndexSet) {
        //users.remove(atOffsets: offsets)
        print("yoyoyoyoyooy")
        
    }
    
    func loadData() async {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        
        guard let url = urlComponents.url else {
            print("URL is invalid")
            return
        }
        print(url.absoluteString)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([Result].self, from: data) {
                self.results = decodedResponse
                print("Results fetched")
            }
        } catch {
            print("Invalid data from url")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
