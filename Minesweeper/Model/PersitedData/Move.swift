//
//  Move.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 12/08/2022.
//

import Foundation
import RealmSwift

class Move: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var row: Int
    @Persisted var col: Int
}
