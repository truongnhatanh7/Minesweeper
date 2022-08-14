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

struct PreHomeRegisterView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var canNavigate: Bool = false
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
                viewManipulation = 0
            } label: {
                Text("Already have an account? Log in")
                    .underline()
                    .foregroundColor(Color("text"))
            }
            
            Button {
                for user in game.getUsers() {
                    if user.username == self.username {
                        showAlert = true
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
        .alert("This username is already existed", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        .onAppear() {
            game.backgroundAudioManager.clearSounds()
        }
    }
}

struct PreHomeRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        PreHomeRegisterView(viewManipulation: HomeView().$viewManipulation)
    }
}
