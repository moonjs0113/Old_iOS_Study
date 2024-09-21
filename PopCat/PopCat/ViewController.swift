//
//  ViewController.swift
//  Pop Cat
//
//  Created by 문종식 on 2021/02/07.
//

import UIKit
import Combine
import AVFoundation

class ViewController: UIViewController {
    // MARK: - Properties
    var viewModel: ViewModel = ViewModel()
    var anyCancellable: Set<AnyCancellable> = .init()
    var audioPlayerList: [AVAudioPlayer] = [AVAudioPlayer()]
    
    // MARK: - IBOutlet
    @IBOutlet var backgroudButton: UIButton!
    @IBOutlet var appearanceButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Methods
    func setUIBinding() {
        viewModel.$appearance
            .sink { [weak self] appearance in
                self?.appearanceButton.setImage(
                    appearance.buttonImage,
                    for: .normal
                )
                self?.overrideUserInterfaceStyle = appearance.interfaceStyle
            }
            .store(in: &anyCancellable)
        
        viewModel.$background
            .sink { [weak self] background in
                guard let self else { return }
                self.backgroudButton.setImage(
                    background.buttonImage,
                    for: .normal
                )
            }
            .store(in: &anyCancellable)
        
        viewModel.$touchState
            .sink { [weak self] touchState in
                if touchState == .ended {
                    self?.playSound()
                }
            }
            .store(in: &anyCancellable)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(didTouch(_:))
        )
        longPressGestureRecognizer.minimumPressDuration = 0
        self.imageView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "popSound.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayerList.append(audioPlayer)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("couldn't load the file")
        }
    }
    
    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
     }
    
    // MARK: - IBAction
    
    // 배경 표시
    @IBAction func touchUpBackgroundButton(_ sender: UIButton) {
        viewModel.toggleBackground()
        imageView.image = UIImage(named: viewModel.imageName)
    }
    
    @IBAction func touchUpAppearanceButton(_ sender: UIButton) {
        viewModel.toggleAppearance()
    }
    
    // MARK: - Object Function
    @objc func didTouch(_ sender: UILongPressGestureRecognizer) {
        let x = sender.location(in: imageView).x
        viewModel.direction = (x > view.frame.width / 2) ? .right : .left
        viewModel.touchState = (sender.state == .ended) ? .ended : .touch
        imageView.image = UIImage(named: viewModel.imageName)
    }
    
    // MARK: - Life Cyecle
    override func loadView() {
        super.loadView()
        setUIBinding()
        if traitCollection.userInterfaceStyle == .dark {
            viewModel.appearance = .dark
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
