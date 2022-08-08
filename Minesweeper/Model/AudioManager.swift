//
//  AudioManager.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 08/08/2022.
//

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
}
