//
//  NetworkView.swift
//  Concurrency
//
//  Created by Moon Jongseek on 2022/06/30.
//

import SwiftUI

struct NetworkView: View {
    @State private var stepList: [Step] = []
    let viewModel: NetworkManager = NetworkManager.shared
    
    var body: some View {
        VStack {
            Text("Step List")
                .padding()
                .onAppear {
                    
                }
            Button("Get Step await") {
                Task {
                    self.stepList = await self.viewModel.getAllStep(route: "/step")
                }
            }
            
            Button("Get Step try await") {
                Task {
                    do {
                        self.stepList = try await self.viewModel.getAllStepTry()
                    } catch {
                        self.stepList = []
                    }
                }
            }
            
            Button("Clear") {
                self.stepList = []
            }
            
            List(self.stepList, id: \.title) { step in
                Text("\(step.title): \(step.content)")
            }
        }
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
