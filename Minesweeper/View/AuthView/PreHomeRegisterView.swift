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
            Text("MINESWEEPER")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("text"))
            VStack {
                TextField("Username", text: $username)
                    .modifier(TextfieldModifer())
                    .padding(.bottom, 18)
                SecureField("Password", text: $password)
                    .modifier(TextfieldModifer())
            }
            .padding()

            Button  {
                viewManipulation = 0
            } label: {
                Text("Already have an account? Log in")
                    .underline()
                    .foregroundColor(Color("text"))
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
                    .background(Color("neonGreen"))
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
