//
//  ViewModel.swift
//  PopCat
//
//  Created by Moon Jongseek on 8/25/24.
//

import Foundation

final class ViewModel {
    @Published var background: Backgroud = .empty
    @Published var appearance: Appearance = .light
    @Published var direction: Direction = .right
    @Published var touchState: TouchState = .ended
    
    var imageName: String {
        var imageName = "pop"
        imageName += (touchState == .ended) ? "_off" : "_on"
        imageName += (direction == .right) ? "" : "_left"
        imageName += (background == .empty) ? "" : "_background"
        return imageName
    }
    
    public func toggleBackground() {
        background = background.toggle()
    }
    
    public func toggleAppearance() {
        appearance = appearance.toggle()
    }
    
    init() {
        
    }
}
