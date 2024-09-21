//
//  AVPlayer.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/06/18.
//

import SwiftUI
import AVFoundation

class ChildAVAudioPlayer: AVAudioPlayer {    
    deinit {
        print("Deinit ChildAVAudioPlayer")
    }
}

class AudioPlayer {
    private var player: ChildAVAudioPlayer = ChildAVAudioPlayer()
    
    init(name: String, type: String, volumn: Float = 1) {
        

        // 초기화
        if let url = Bundle.main.url(forResource: name, withExtension: type) {
            print("success audio file: \(name)")
            do {
                player = try ChildAVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.setVolume(volumn, fadeDuration: 0)
            } catch {
                print("error getting audio \(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        print("deinit AudioPlayer")
    }
    
    // 시작
    func start() {
        player.play()
    }
    // 멈춤.
    func pause() {
        player.pause()
//        player = nil
    }
    
}
struct AVPlayer: View {
    @State private var introSound: AudioPlayer = AudioPlayer(name: "css_test", type: "mp3")
    
    var body: some View {
        VStack {
            Button{
                introSound.start()
            } label: {
                Text("introSound")
            }
            NavigationLink {
                Text("New Page")
            } label: {
                Text("New Page")
            }
        }
        .onDisappear {
            print("introSound.pause()")
            introSound.pause()
//            introSound = nil
            print(introSound)
        }
    }
}

struct AVPlayer_Previews: PreviewProvider {
    static var previews: some View {
        AVPlayer()
    }
}
