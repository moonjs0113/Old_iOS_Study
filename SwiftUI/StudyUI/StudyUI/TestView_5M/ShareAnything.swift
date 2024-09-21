//
//  ShareAnything.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/25.
//

import SwiftUI

class AirDropCustomData: NSObject, UIActivityItemSource {
    var url: URL
    var subject: String
    
    init(url: URL, subject: String) {
        self.url = url
        self.subject = subject
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return url
    }
    
    func activityViewController(
        _ activityViewController: UIActivityViewController,
        itemForActivityType activityType: UIActivity.ActivityType?
    ) -> Any? {
        return url
    }
    
    func activityViewController(
        _ activityViewController: UIActivityViewController,
        subjectForActivityType activityType: UIActivity.ActivityType?
    ) -> String {
        return subject
    }
    
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
        if activityType == .airDrop {
            return UIImage(named: "AppIcon")
        }
        return nil
    }
}

struct AirDropModel {
    let urlString: String
    var urlScheme: URL?
    
    let image: UIImage
    var imageData: Data
    
    public init(urlString: String, image: UIImage) {
        self.image = image
        self.imageData = self.image.pngData() ?? Data()
        
        self.urlString = urlString //+ "&image=\(self.imageData.base64EncodedString().lengthOfBytes(using: .utf8))"
        if let urlScheme = URL(string: self.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
//            self.urlScheme = URL(dataRepresentation: self.imageData, relativeTo: urlScheme)
            self.urlScheme = urlScheme
        }
    }
}

class test: UIActivityItemProvider {
    
}

class ActivityItem: NSObject, UIActivityItemSource {
    let model: AirDropModel
    
    init(model: AirDropModel) {
        self.model = model
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "미모지 AirDrop"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return self.model
    }
}

struct ShareAnything: View {
    @State private var isSharePresented: Bool = false
    @State private var isSharePresented2: Bool = false
    
    let nickname = "Rey"
    let firstString = "#조금_늦어도_괜찮아"
    let secondString = "#IT_Specialist"
    
    var body: some View {
        VStack {
            Button("Share app") {
                self.isSharePresented = true
            }
            .sheet(isPresented: self.$isSharePresented) {
                let airdrop = AirDropModel(urlString: "urlscheme://?nickname=\(self.nickname)&firstString=\(self.firstString)&secondString=\(self.secondString)&isShow=\(true)",
                                           image: UIImage(named: "Example") ?? UIImage())
                ActivityViewController(airDropModel: airdrop)
            }
            
            List {
                Text("adsf")
                Text("adsf")
                Text("adsf")
            }
        }
        
        //        Button("Share app") {
        //            self.isSharePresented2 = true
        //        }
        //        .sheet(isPresented: self.$isSharePresented2, onDismiss: {
        //            print("Dismiss")
        //        }, content: {
        //
        //            ActivityViewController(activityItems: [])
        //        })
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    var airDropModel: AirDropModel
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        //        let activityItem: ActivityItem = ActivityItem(model: self.airDropModel)
        //        let list: [Any] = [self.airDropModel.image, self.airDropModel.urlScheme]
        
        //        let fullString = NSMutableAttributedString(string: self.airDropModel.urlString)
        //        let image1Attachment = NSTextAttachment()
        //        image1Attachment.image = self.airDropModel.image
        //        let image1String = NSAttributedString(attachment: image1Attachment)
        //        fullString.append(image1String)
        
//        let path1 = Bundle.main.path(forResource: "readme 1", ofType: "airdrop")
//        let url1 = URL(fileURLWithPath: path1 ?? "")
//        let item1 = AirDropCustomData(url: url1, subject: "readme 1")
//
//        let path2 = Bundle.main.path(forResource: "readme 2", ofType: "airdrop")
//        let url2 = URL(fileURLWithPath: path2 ?? "")
//        let item2 = AirDropCustomData(url: url2, subject: "readme 2")
//
//        let items = [item1, item2] // MemojiActivityViewContoller 여기 파라미터로 씀
        
        
        
//        let anyList: [Data] = [self.airDropModel.urlScheme?.dataRepresentation ?? Data(), self.airDropModel.imageData]
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: anyList)
//        let base64String = encodedData.base64EncodedString()
//        let data = Data(base64Encoded: base64String) // ?? Data()
        
        //        var urlData = self.airDropModel.urlScheme?.dataRepresentation
        //        urlData?.append(self.airDropModel.imageData)
        
        
        let controller = MemojiActivityViewContoller(activityItems: [self.airDropModel.urlScheme],
                                                     applicationActivities: nil)
        controller.excludedActivityTypes = [.message,
                                            .mail,
                                            .markupAsPDF,
                                            .saveToCameraRoll,
                                            .assignToContact,
                                            .copyToPasteboard,
                                            .addToReadingList,
                                            .openInIBooks,
                                            .postToFacebook,
                                            .postToFlickr,
                                            .postToTencentWeibo,
                                            .postToTwitter,
                                            .postToVimeo,
                                            .postToWeibo,
                                            .print
        ]
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {
        
    }
}

class MemojiActivityViewContoller: UIActivityViewController, UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        
        return Data()
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return Data()
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "AirDrop Profile File Type"
    }
}

struct ShareAnything_Previews: PreviewProvider {
    static var previews: some View {
        ShareAnything()
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
//    //    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    //    ) {
//    // Record the device token.
//    //    }
//    
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
//        if connectingSceneSession.role == .windowApplication {
//            configuration.delegateClass = SceneDelegate.self
//        }
//        return configuration
//    }
//    
//}
//
//class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        if let _url = connectionOptions.urlContexts.first?.url {
//            self.schemeHandleURL(url: _url)
//        }
//    }
//    
//    func schemeHandleURL (url: URL){
//        
//    }
//}


