//
//  About_ForEach.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

// ForEach
// - Sectioned List
// - Delete / Move
// - Custom List UI

struct AboutForEach: View {
    var items = AppleProduct.sampleList
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(items) { item in
                        ProductGridItem(product: item)
                    }
                }
                .padding()
            }
            ScrollView {
                VStack {
                    ForEach(0..<3) { row in
                        HStack {
                            ForEach(0..<2) { col in
                                ProductGridItem(product: items[row*3+col])
                            }
                        }
                    }
                }
            }
        }
    }
}

struct About_ForEach_Previews: PreviewProvider {
    static var previews: some View {
        AboutForEach()
    }
}

struct ProductGridItem: View {
    let product: AppleProduct
    
    init(product: AppleProduct) {
        self.product = product
        
        print("init \(product.name)")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.category)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(product.name)
                .font(.title2)
            
            Text(product.summary)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
            
            Spacer()
        }
    }
}
