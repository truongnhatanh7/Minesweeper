/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Truong Nhat Anh
 ID: 3878231
 Created date: 10/08/2022
 Last modified: dd/mm/yyyy 11/08/2022
 Acknowledgement: COSC2659 Lecture slides, hackingwithswift.com, stackoverflow.com, minesweepergame.com
 */

import SwiftUI
import RealmSwift

struct PreHomeLoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @Binding var viewManipulation: Int
    @EnvironmentObject var game: Game
    @State private var showAlert = false
    
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
                        game.canContinue = user.canContinue
                        viewManipulation = 3
                        return
                    }
                }
                showAlert = true
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
        .alert("Wrong information", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct PreHomeLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PreHomeLoginView(viewManipulation: HomeView().$viewManipulation)
    }
}
