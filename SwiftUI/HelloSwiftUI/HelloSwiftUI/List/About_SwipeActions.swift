//
//  About_SwipeActions.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutSwipeActions: View {
    @State private var favorites = [AppleProduct]()
    @State private var allProducts = AppleProduct.sampleList
    
    var body: some View {
        List {
            Section("Favorites") {
                ForEach(favorites) { item in
                    Text(item.name)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    if let index = self.favorites.firstIndex(of: item) {
                                        favorites.remove(at: index)
                                    }
                                    
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
            }
            
            Section("All Products") {
                ForEach(allProducts) { item in
                    Text(item.name)
                    // edge Default Value: trailing
                        .swipeActions(edge: .leading) {
                            Button(role: .destructive) {
                                withAnimation {
                                    if let index = self.favorites.firstIndex(of: item) {
                                        favorites.remove(at: index)
                                    }
                                    
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                            
                            Button {
                            
                            } label: {
                                Text("")
                            }
                        }
                        .swipeActions(allowsFullSwipe: false) {
                                Button {
                                    withAnimation {
                                        self.favorites.append(item)
                                    }
                                } label: {
                                    Image(systemName: "hand.thumbsup")
                                }
                                .tint(.cyan)
                        }
                }
            }
        }
    }
}

struct About_SwipeActions_Previews: PreviewProvider {
    static var previews: some View {
        AboutSwipeActions()
    }
}
