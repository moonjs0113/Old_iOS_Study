//
//  StudyUIApp.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/17.
//

import SwiftUI
import Firebase

@main
struct StudyUIApp: App {
    
    
    init() {
        FirebaseApp.configure()
    }
    
    @State var imageData: Data = Data()
    @State var metaData: String = ""
    
    var body: some Scene {
        WindowGroup {
            MainView(imageData: self.$imageData, metaData: self.$metaData)
                .onOpenURL { url in
                    let urlStr = url.absoluteString // [스키마 주소값 가지고 온다]
                    let components = URLComponents(string: urlStr) // 전체 주소
                    //                    let schemeData = components?.scheme ?? "" // 스키마
                    //                    let parameter = components?.query ?? "" // 파라미터
                    //
                    //                    self.urlString = "urlStr : " + urlStr // + "\nscheme : " + schemeData + "\nquery : " + parameter + url.pathExtension
                    //                    print(self.urlString)
                    
                    if let queryItems = components?.queryItems {
                        for item in queryItems {
                            if let ID = item.value, item.name == "ID" {
                                let storage = Storage.storage()
                                let pathReference = storage.reference(withPath: "\(ID)")
                                pathReference.getData(maxSize: 1 * 1024 * 1024) { optionalData, _ in
                                    if let data = optionalData {
                                        self.imageData = data
                                    }
                                }
                                pathReference.getMetadata { metadata, _ in
                                    print(metadata?.dictionaryRepresentation())
                                }
                            }
                        }
                    }
                }
        }
    }
}
