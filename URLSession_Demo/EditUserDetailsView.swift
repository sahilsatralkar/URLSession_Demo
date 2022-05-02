//
//  EditUserDetailsView.swift
//  URLSession_Demo
//
//  Created by Sahil Satralkar on 02/05/22.
//

import SwiftUI

struct EditUserDetailsView: View {
    
    var user : Result
    
    var body: some View {
        VStack {
            Text("Name: \(user.name)")
        }
    }
}

struct EditUserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserDetailsView(user: Result(id: 1, name: "", email: "", gender: "", status: ""))
    }
}
