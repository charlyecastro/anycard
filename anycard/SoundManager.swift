//
//  SoundManager.swift
//  anycard
//
//  Created by Charlye Castro on 1/24/21.
//  Copyright © 2021 Charlye Castro. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    var audioPlayer:AVAudioPlayer?
    
    
    func play(){
        let soundFileName = "camera-shutter"
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
        
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        do {
            print("Plaing audio")
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        catch {
            print("Couldnt Create Audio Player")
            return
        }
        
    }
}
