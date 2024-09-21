//
//  Appearance.swift
//  PopCat
//
//  Created by Moon Jongseek on 8/23/24.
//

import UIKit

enum Appearance {
    case light
    case dark
    
    func toggle() -> Self {
        return self == .light ? .dark : .light
    }
    
    var buttonImage: UIImage? {
        var imageName = "moon.fill"
        if self == .dark {
            imageName = "sun.max.fill"
        }
        return UIImage(systemName: imageName)
    }
    
    var interfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
