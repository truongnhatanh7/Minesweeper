/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Truong Nhat Anh
 ID: 3878231
 Created date: 10/08/2022
 Last modified: 11/08/2022
 Acknowledgement: COSC2659 Lecture slides, hackingwithswift.com, stackoverflow.com, minesweepergame.com
 */

import Foundation
import RealmSwift

class Move: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var row: Int
    @Persisted var col: Int
}
