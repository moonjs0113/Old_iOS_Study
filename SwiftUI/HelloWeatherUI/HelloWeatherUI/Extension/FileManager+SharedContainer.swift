//
//  FileManager+SharedContainer.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/05.
//

import Foundation

extension FileManager {
    static var sharedContainerURL: URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.moonjs.HelloWeatherUI") ?? URL(fileURLWithPath: "")
    }
}
