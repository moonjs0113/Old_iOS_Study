//
//  memoji.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/26.
//

import SwiftUI
import PhotosUI
import Firebase
import UIKit
import LinkPresentation

struct MemojiSendModel {
    let urlString: String
    var urlScheme: URL?
    
    public init(urlString: String) {
        self.urlString = urlString
        if let urlScheme = URL(string: self.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            self.urlScheme = urlScheme
        }
    }
}

struct Memoji: View {
    let storage = Storage.storage()
    
    @State private var picker: Bool = false
    @State private var selectedImage: UIImage = UIImage()
    @State private var uploading = false
    @State private var percentComplete = 0.0
    @State private var isActivityViewPresented = false
    
    let id: String = "Rey_morning_1.png"
    
    var body: some View {
        VStack {
            Image(uiImage: self.selectedImage)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(20)
            Button("Selected Image") {
                self.picker.toggle()
            }
            .sheet(isPresented: self.$picker) {
                ImagePicker(images: self.$selectedImage, picker: self.$picker)
            }
            if self.uploading {
                ProgressView(value: self.percentComplete)
                    .progressViewStyle(.circular)
            } else {
                Button("Upload") {
                    self.uploading.toggle()
                    if let data = selectedImage.pngData() {
                        let storageRef = self.storage.reference().child("Rey_morning_1.png")
                        let customMetadata: [String:String] = [
                            "nickname" : "Rey",
                            "session" : "morning",
                            "firstString" : "#조금_늦어도_괜찮아",
                            "secondString" : "#IT_Specialist"
                        ]
                        let metaDataDictionary: [String : Any] = [
                            "contentType" : "image/png",
                            "customMetadata" : customMetadata
                        ]
                        let storageMetadata = StorageMetadata(dictionary: metaDataDictionary)
                        let uploadTask = storageRef.putData(data, metadata: storageMetadata)
                        
                        uploadTask.observe(.progress) { snapshot in
                            self.percentComplete = Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                        }
                        
                        uploadTask.observe(.success) { snapshot in
                            if self.percentComplete == 1.0 {
                                self.uploading.toggle()
                            }
                        }
                    }
                }
            }
            
            
            Button("Share") {
                self.isActivityViewPresented = true
            }.sheet(isPresented: self.$isActivityViewPresented) {
                let memojiSendModel = MemojiSendModel(urlString: "urlscheme://?ID=\(self.id)")
                MemojiActivityViewController(memojiSendModel: memojiSendModel)
            }
            
            Button("Storage Test") {
                let storageRef = self.storage.reference().child("Rey0.png")
                
                print(storageRef)
                print(storageRef.fullPath)
                print(storageRef.name)
            }
        }
    }
}

//class MemojiActivity: UIActivity {
//    override class var activityCategory: UIActivity.Category = .share
//    override var activityType: UIActivity.ActivityType? = .airDrop
//}

struct MemojiActivityViewController: UIViewControllerRepresentable {
    let memojiSendModel: MemojiSendModel
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MemojiActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: [MyActivityItemSource(), self.memojiSendModel.urlScheme],
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
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<MemojiActivityViewController>) {
        
    }
}


class MyActivityItemSource: NSObject, UIActivityItemSource {
    var title: String = "Memoji Collection"
    var text: String = "미모지를 보내세요!"
    
//    init(title: String, text: String) {
//        self.title = title
//        self.text = text
//        super.init()
//    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        metadata.iconProvider = NSItemProvider(object: UIImage(named: "AppIcon")!)
        //This is a bit ugly, though I could not find other ways to show text content below title.
        //https://stackoverflow.com/questions/60563773/ios-13-share-sheet-changing-subtitle-item-description
        //You may need to escape some special characters like "/".
        metadata.originalURL = URL(fileURLWithPath: text)
        return metadata
    }

}


struct ImagePicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self )
    }
    
    @Binding var images : UIImage
    @Binding var picker : Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent :ImagePicker
        
        init(parent1 : ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.picker.toggle()
            
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
                        guard let selectedImage = image else {
                            print("err ")
                            return
                        }
                        if let uiImage = selectedImage as? UIImage {
                            self.parent.images = uiImage
                        }
                        
//                        if !self.parent.images.isEmpty {
//                            self.parent.images.remove(at: 0)
//                        }
//                        self.parent.images.append(selectedImage as! UIImage )
                    }
                } else {
                    print("cannot be loaded ")
                }
            }
        }
    }
}


class ImageFileManager {
    static let shared: ImageFileManager = ImageFileManager()
    
    func saveImage(image: UIImage, name: String) {
        guard let data: Data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return }
        if let directory: NSURL = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) as NSURL {
            do {
                try data.write(to: directory.appendingPathComponent(name)!)
            } catch let error as NSError {
                print("Could not saveImage: \(error), \(error.userInfo)")
            }
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir: URL = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) {
            let path: String = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path
            let image: UIImage? = UIImage(contentsOfFile: path)
            return image
        }
        return nil
    }
}


struct Memoji_Previews: PreviewProvider {
    static var previews: some View {
        Memoji()
    }
}


enum script {
    case text, button
    
    var uiScript: String {
        switch self {
        case .text:
            return "A view that displays one or more lines of read-only text."
        case .button:
            return ""
        }
    }
}
