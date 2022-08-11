//
//  PreHomeRegisterView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 08/08/2022.
//

import SwiftUI

struct PreHomeRegisterView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var canNavigate: Bool = false
    @Binding var viewManipulation: Int
    @EnvironmentObject var game: Game
    
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
                viewManipulation = 0
            } label: {
                Text("Already have an account? Log in")
            }
            
            
            Button {
                for user in game.getUsers() {
                    if user.username == self.username {
                        // TODO: Warn collapsed username
                        print("collapsed")
                        return
                    }
                }
                
                game.addUser(username: self.username, password: self.password)
                game.currentUsername = username
                viewManipulation = 3
            } label: {
                Text("Register")
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

struct PreHomeRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        
        PreHomeRegisterView(viewManipulation: HomeView().$viewManipulation)
    }
}
