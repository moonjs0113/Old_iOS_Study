//
//  MainView.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/19.
//

import SwiftUI

struct MainView: View {
    @StateObject private var dataController11 = DataController(containerName: "Bookworm")
    @StateObject private var dataController12 = DataController(containerName: "Prjc12")
    
    @Binding var imageData: Data
    @Binding var metaData: String
    
    @State private var showDictionary = false
    
    var text: [String] = ["Text", "Button", "Stack", "NavigationView"]
    
    var body: some View {
        NavigationView{
            Form {
                Section("실험실") {
                    NavigationLink("ViewLifeCycle", destination: LifeCycle())
                    NavigationLink("AVPlayer", destination: AVPlayer())
                    NavigationLink("Concurrency", destination: ConcurrencyView())
                    NavigationLink("아무개", destination: GhostView())//아무개_View())
                    NavigationLink("TextEditor", destination: TextEditorView())
                    NavigationLink("TempCustomNavigationView", destination: TempCustomNavigationView())
                }
                Section {
                    ForEach(self.text, id:\.self) { title in
                        NavigationLink("\(title)", destination: Text(title))
                    }
                }
                
                Section {
                    NavigationLink("Project 1", destination: Day16())
                    NavigationLink("Project 2", destination: Day20())
                    NavigationLink("Project 3", destination: Day23())
                    NavigationLink("뫼비우스", destination: MainView(imageData: self.$imageData, metaData: self.$metaData))
                    NavigationLink("Consolidation II", destination: Consolidation2())
                } header: {
                    Text("Consolidation II")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                
                Section("Consolidation III") {
                    NavigationLink("Project 4", destination: Day26())
                    NavigationLink("Project 5", destination: Day29())
                    NavigationLink("Project 6", destination: Day32())
                }
                
                Section("Consolidation IV") {
                    NavigationLink("Project 7", destination: Day36())
                    NavigationLink("Project 8", destination: Day39())
                    NavigationLink("Project 9", destination: Day43())
                }
                
                Section("Consolidation V") {
                    NavigationLink("Project 10", destination: Day49())
                    NavigationLink("Project 11", destination: Day53()
                                    .environment(\.managedObjectContext, self.dataController11.container.viewContext)
                    )
                    NavigationLink("Project 12", destination: Day57()
                                    .environment(\.managedObjectContext, self.dataController12.container.viewContext)
                    )
                }
                Section("코드 모음") {
                    Group{
                        Group {
                            NavigationLink("AnimationAsync", destination: AnimationAsync())
                            NavigationLink("ViewContainers", destination: ViewContainers())
                            NavigationLink("UserInterfaceElements", destination: UserInterfaceElements())
                            NavigationLink("Shapes", destination: Shapes())
                            NavigationLink("Test View", destination: TestView())
                        }
                        Group {
                            NavigationLink("OCR", destination: OCR())
                            NavigationLink("PopToRoot", destination: RootView())
                            NavigationLink("Closures", destination: Closures())
                            NavigationLink("ViewDrawing", destination: WrappedViewDrawing())
                            NavigationLink("ScrollPinView", destination: ScrollPinView())
                        }
                        Group {
                            NavigationLink("Method Swizzling", destination: MethodSwizzling())
                            NavigationLink("Memory", destination: ARCView())
                        }
                    }
                    Group{
                        if let uiImage = UIImage(data: self.imageData) {
                            Image(uiImage: uiImage)
                        }
                        Text(self.metaData)
                        NavigationLink("ShareAnything", destination: ShareAnything())
                        NavigationLink("Memoji", destination: Memoji())
                        Button("Dictionary") {
                            self.showDictionary.toggle()
                        }
                    }
                    
                }
                
            }
            .navigationTitle("SwiftUI Study App")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: self.$showDictionary) {
            NavigationView {
                DictionaryView()
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(urlString: "")
//    }
//}
