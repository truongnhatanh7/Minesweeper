//
//  PreHomeLoginView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 08/08/2022.
//

import SwiftUI

struct PreHomeLoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @Binding var viewManipulation: Int
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        
        VStack {
            Text("Minesweeper")
                .font(.largeTitle)
            VStack {
                TextField("Username", text: $username)
                    .padding()
                    .background(.teal)
                    .cornerRadius(5.0)
                    .padding(.bottom, 18)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.teal)
                    .cornerRadius(5.0)
            }
            .padding()

            Button  {
                viewManipulation = 1
            } label: {
                Text("Don't have an account? Sign up")
            }
            
            
            Button {
                for user in realmManager.users {
                    print("\(user.username) \(user.password)")
                    if user.username == self.username && user.password == self.password {
                        viewManipulation = 3
                    }
                }
            } label: {
                Text("Login")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.mint)
                    .cornerRadius(5.0)
                
            }
            .padding()

        }
    }
}

struct PreHomeLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PreHomeLoginView(viewManipulation: HomeView().$viewManipulation)
    }
}
