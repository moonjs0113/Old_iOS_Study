//
//  Step.swift
//  Concurrency
//
//  Created by Moon Jongseek on 2022/06/30.
//

import Foundation

struct Step: Codable {
    var courseID: UUID // 코스의 ID
    var currentStep: Int // 현재 단계
    var totalStep: Int // 총 단계
    var title: String // 현재 단계의 제목
    var content: String // 현재 단계의 내용
}
