//
//  RealmManager.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 09/08/2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published var users: [User] = []
    
    init() {
        openRealm()
        self.users = getUsers()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                    // Do something, usually updating the schema's variables here
                }
            })

            Realm.Configuration.defaultConfiguration = config

            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    func addUser(username: String, password: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let user = User()
                    user.username = username
                    user.password = password
                    localRealm.add(user)
                    print("Added new user to Realm!")
                }
            } catch {
                print("Error adding user to Realm", error)
            }
        }
    }
    
    func getUsers() -> [User] {
        if let localRealm = localRealm {
            let allUsers = localRealm.objects(User.self)
            allUsers.forEach { user in
                users.append(user)
            }
        }
        return self.users
    }
    
    
}
