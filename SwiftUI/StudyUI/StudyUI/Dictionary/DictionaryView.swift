//
//  DictionaryView.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/29.
//

import SwiftUI

struct DictionaryView: View {
    var titleCategory: [TitleCategory]?
    
    var body: some View {
//        NavigationView{
            Form {
                if let titleCategoryList = self.titleCategory {
                    ForEach(titleCategoryList, id: \.self) { titleCategory in
                        Section {
                            ForEach(titleCategory.uiComponent ?? [], id: \.self) { uiComponenet in
                                NavigationLink("\(uiComponenet.name)", destination: UIDetailView(uiComponent: uiComponenet))
                            }
                        } header: {
                            Text("\(titleCategory.name)")
                        }
                    }
                } else {
                    ForEach(swiftUICategory.childTitleCategory, id: \.self) { titleCategory  in
                        Section {
                            ForEach(titleCategory.childCategory ?? [], id: \.self) { category in
                                NavigationLink("\(category.name)", destination: DictionaryView(titleCategory: category.childTitleCategory))
                            }
                        } header: {
                            Text("\(titleCategory.name)")
                        }
                    }
                }
            }
            .navigationTitle("NavigationTitle")
            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}



struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}
