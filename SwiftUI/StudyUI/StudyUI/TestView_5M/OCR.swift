//
//  OCR.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/25.
//

import SwiftUI
import AVFoundation
import Vision
import Alamofire

struct OCRRequestModel: Codable {
    var version: String = "V2"
    var requestId: String = "reqeustGuide"
    var timestamp: Int = Date().timeIntervalSinceNow.exponent
    var lang: String = "ko"
    var images: [OCRRequestImage]?
}

struct OCRRequestImage: Codable {
    var format: String = "png"
//    var data: String
    var name: String = "image"
}

struct OCR: View {
    @ObservedObject var camera = CameraViewModel()
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
//                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                HStack {
//                    Button {
//                        self.showModal.toggle()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.white)
//                            .font(.largeTitle)
//                    }
                    Spacer()
                    Button {
                        camera.reTake()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                    }
                    .opacity(camera.isTaken ? 1 : 0)
                }
                .padding([.leading, .trailing, .top])
                Spacer()
                HStack {
                    if camera.isTaken {
                        Button {
                            if !camera.isSaved {
//                                camera.savePic()
                            }
                        } label: {
                            Image(systemName: camera.isSaved ? "square.and.arrow.down.fill" : "square.and.arrow.down" )
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(.gray)
                                .clipShape(Capsule())
                        }
                        
                        Spacer()
                        
                        Button {
                            self.camera.requestToNCP()
//                            self.camera.requestToText()
                        } label: {
                            HStack {
                                Image(systemName: "map")
                                    .foregroundColor(.white)
                                Text("업로드")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(.gray)
                            .clipShape(Capsule())
                        }
                        
                        Button {
                            self.camera.requestToText()
                        } label: {
                            Text("Vision")
                                .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(.gray)
                            .clipShape(Capsule())
                        }
                        
                    } else {
                        Button {
                            camera.takePic()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                }
                .frame(height: 75)
                .padding([.leading, .trailing])
            }
        }
        .onAppear {
            camera.check()
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: setUp()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied: self.alert.toggle()
        default : return
        }
    }
    
    func setUp() {
        do {
            self.session.beginConfiguration()
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video,  position: .back) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            guard self.session.canAddInput(input) else { return }
            self.session.addInput(input)
            guard self.session.canAddOutput(self.output) else { return }
            self.session.sessionPreset = .photo
            self.session.addOutput(self.output)
            self.session.commitConfiguration()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        withAnimation {
            self.isTaken = true
        }
    }
    
    func reTake() {
        self.session.startRunning()
        withAnimation {
            self.isTaken = false
            self.isSaved = false
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.session.stopRunning()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else { return }
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.picData = imageData
    }
    
    func savePic() {
        guard let image = UIImage(data: self.picData) else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.isSaved = true
    }
    
    func requestToNCP() {
        let secretKey = "WllrWkNqZFRiZ2tQTVdQWHNLdHVOQ0lER0lZUHFiSXM="
        let invokeURL = "https://4ccdf4cd91d74b5da9cdd9c5f5321e41.apigw.ntruss.com/custom/v1/15525/bb5a0ba92c3044b7fb70de99e31eaced068228c53202d801ce4050836a6244d6/general"
        let _ = "http://clovaocr-api-kr.ncloud.com/external/v1/15525/bb5a0ba92c3044b7fb70de99e31eaced068228c53202d801ce4050836a6244d6"
        guard let imageData = UIImage(data: self.picData)?.pngData() else {
            print("imageData Fail")
            return
            
        }
//        print(imageData)
        if let url = URL(string: invokeURL) {
            let httpHeaders: HTTPHeaders = ["X-OCR-SECRET" : secretKey]
            let jsonParameter: [String : Any] = [
                "images": [
                    [
                        "format" : "png",
                        "name" : "image",
                        "url" : "",
                        "data" : InputStream.init(data: imageData)
                    ]
                ],
                "requestId" : UUID().uuidString,
                "version" : "V2",
                "timestamp" : Int(Date.now.timeIntervalSince1970)
            ]
//            print(jsonParameter.debugDescription)
            
            AF.request(url, method: .post, parameters: jsonParameter, headers: httpHeaders).responseString { response in
                print(response.request)
                print(response.response)
                debugPrint(response)
                
            }
            
//            let boundary = "Boundary-\(UUID().uuidString)"
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue(secretKey, forHTTPHeaderField: "X-OCR-SECRET")
//            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            
            
//            let ocrRequestModel = OCRRequestModel(images: [OCRRequestImage()])
//
//            guard let encoded = try? JSONEncoder().encode(ocrRequestModel) else {
//                print("Failed to encode order")
//                return
//            }
//
//            request.httpBody = encoded
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                print("\ndata")
//                print(data)
//                print("\nresponse")
//                print(response)
//            }.resume()
            
            
        }
    }
    
    func createBody(paramaeters: [String: Any], boundary: String, imageData: Data) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"

        for (key, value) in paramaeters {
            body.append(boundaryPrefix.data(using: .utf8)!)
          body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
          body.append("\(value)\r\n".data(using: .utf8)!)
        }

        // image를 첨부하지 않아도 작동할 수 있도록 if let을 통해 images 여부 확인
        // requst의 key값의 이름에 따라 name의 값을 변경
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"images[]\"; filename=\"image\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        body.append(boundaryPrefix.data(using: .utf8)!)

        return body
    }
    
    func requestToText() {
        guard let cgImage = UIImage(data: self.picData)?.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNRecognizeTextRequest { request, error in  //(completionHandler: self.recognizeTextHandler)
            guard let observations =
                    request.results as? [VNRecognizedTextObservation] else {
                return
            }
            
            print()
            print(observations)
            print()
            
            
            let recognizedStrings = observations.compactMap { observation in
                return observation.topCandidates(1).first?.string
            }
            print(recognizedStrings)
        }
        
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["Ko"]

        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
}

struct OCR_Previews: PreviewProvider {
    static var previews: some View {
        OCR()
    }
}
