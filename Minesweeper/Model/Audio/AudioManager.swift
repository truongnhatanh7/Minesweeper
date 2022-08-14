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
import AVKit

class AudioManager {
    var audioPlayer: AVAudioPlayer?
    
    func playSounds(soundfile: String, type: String, repeatNum: Int) {
           if let path = Bundle.main.path(forResource: soundfile, ofType: type){
               do {
                   audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                   audioPlayer?.prepareToPlay()
                   audioPlayer?.play()
                   audioPlayer?.numberOfLoops = repeatNum
               } catch {
                   print("Error")
               }
           }
    }
    
    func clearSounds() {
        audioPlayer?.stop()
    }
}
