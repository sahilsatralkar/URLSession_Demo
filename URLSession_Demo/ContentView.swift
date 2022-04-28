//
//  ContentView.swift
//  URLSession_Demo
//
//  Created by Sahil Satralkar on 23/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = [Result]()
    
    var body: some View {
        Section("Results"){
            List(results, id: \.id){ result in
                VStack (alignment : .leading) {
                    Text (result.name)
                        .font(.headline)
                    Text(result.email)
                    Text(String(result.id))
                }
            }
            .task {
                await loadData()
            }
        }
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
