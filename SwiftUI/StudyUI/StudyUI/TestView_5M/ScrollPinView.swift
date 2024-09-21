//
//  ScrollPinView.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/05/03.
//

import SwiftUI

struct ScrollPinView: View, ScaleDelegate {
    @State var scale: CGFloat = 1.0
    
    func changeScale(scale: CGFloat) {
        self.scale = scale
    }
    
    var body: some View {
        ZoomableScrollView(scaleDelegate: self) {
            Image("Example")
                .overlay {
                    GeometryReader { proxy in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaleEffect(1/self.scale)
//                            .aspectRatio(zoomScale, contentMode: .fit)
                            .foregroundColor(.blue)
                            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                    }
                }
        }
    }
}

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    private var scaleDelegate: ScaleDelegate
    
    init(scaleDelegate: ScaleDelegate, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.scaleDelegate = scaleDelegate
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let scrollView: UIScrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesZoom = true
        
        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content), scaleDelegate: self.scaleDelegate)
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        private var scaleDelegate: ScaleDelegate
        
        init(hostingController: UIHostingController<Content>, scaleDelegate: ScaleDelegate) {
            self.hostingController = hostingController
            self.scaleDelegate = scaleDelegate
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            self.scaleDelegate.changeScale(scale: scrollView.zoomScale)
            print(scrollView.zoomScale)
        }
    }
}

protocol ScaleDelegate {
    func changeScale(scale: CGFloat) -> ()
}

struct ScrollPinView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPinView()
    }
}
