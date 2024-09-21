//
//  ViewController+Extension.swift
//  PopCat
//
//  Created by Moon Jongseek on 8/23/24.
//

import UIKit
import AVFoundation

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayerList.remove(at: audioPlayerList.lastIndex(of: player) ?? 0)
    }
}
