//
//  User.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 09/08/2022.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @objc dynamic var id = UUID()
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var prevBoard = [[Int]]() // 0 close | 1 open | 2 flag
    @objc dynamic var achievements = [String]()
    
}
