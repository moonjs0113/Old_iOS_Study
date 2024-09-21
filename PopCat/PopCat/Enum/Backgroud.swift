//
//  BackgroudType.swift
//  PopCat
//
//  Created by Moon Jongseek on 8/23/24.
//

import UIKit

enum Backgroud {
    case fill
    case empty
    
    func toggle() -> Self {
        return self == .empty ? .fill : .empty
    }
    
    var buttonImage: UIImage? {
        var imageName = "person.circle"
        if self == .fill {
            imageName += ".fill"
        }
        return UIImage(systemName: imageName)
    }
    
    var image: String {
        var imageName = "pop_on"
        if self == .fill {
            imageName += "_background"
        }
        return imageName
    }
    

}
