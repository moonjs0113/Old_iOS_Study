//
//  NetworkManager.swift
//  Concurrency
//
//  Created by Moon Jongseek on 2022/06/30.
//

import Foundation

class NetworkManager {
    let baseURL = "http://ec2-3-85-213-190.compute-1.amazonaws.com/step"
    var url: URL {
        guard let url = URL(string: self.baseURL) else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    static let shared: NetworkManager = NetworkManager()
    
    
    init() {
        
    }
    
    func asyncFunction() async -> String{
        print(#function)
        return #function
    }
    
    // async 한다고 꼭 throws/try를 쓸 필요는 없다.
    func getAllStep(route: String) async -> [Step] {
        guard let url = URL(string: self.baseURL + route) else {
            return []
        }
        
        do {
            let urlRequest = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let stepList = try JSONDecoder().decode([Step].self, from: data)
            return stepList
        } catch (let e) {
            print(e)
        }
        
        return []
    }
    
    func getAllStepTry() async throws -> [Step] {
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let stepList = try JSONDecoder().decode([Step].self, from: data)
        return stepList
    }
}
