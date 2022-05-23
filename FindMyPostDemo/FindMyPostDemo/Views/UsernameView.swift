//
//  UsernameView.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 20/05/2022.
//

import SwiftUI

struct UsernameView: View {
    @State var username: String = "cgriswold"
    @State private var isShowProfiles = false
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 20) {
                TextField("Enter Uersname", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
                
                NavigationLink(destination: ProfilesView(username: username),  isActive: $isShowProfiles) {
                    EmptyView()
                }

                Button("Submit") {
                    print("Button pressed \(username)")
                    isShowProfiles = true
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .font(.system(size: 20, weight: .bold))
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}
