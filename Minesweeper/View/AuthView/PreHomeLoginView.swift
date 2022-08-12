//
//  PreHomeLoginView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 08/08/2022.
//

import SwiftUI
import RealmSwift

struct PreHomeLoginView: View {
    @State var username: String = ""
    @State var password: String = ""
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
                viewManipulation = 1
            } label: {
                Text("Don't have an account? Sign up")
                    .underline()
                    .foregroundColor(Color("text"))
            }
            
            
            Button {
                for user in game.getUsers() {
                    if user.username == self.username && user.password == self.password {
                        game.currentUserId = user._id
                        game.currentUsername = user.username
                        viewManipulation = 3
                    }
                }
            } label: {
                Text("Login")
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

struct PreHomeLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PreHomeLoginView(viewManipulation: HomeView().$viewManipulation)
    }
}
