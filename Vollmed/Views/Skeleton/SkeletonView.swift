//
//  SkeletonView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 29/07/25.
//

import SwiftUI

struct SkeletonView: View {
    
    var body: some View {
        VStack(spacing: 35) {
            ForEach(0..<6, id: \.self) { index in
                SkeletonRow()
            }
        }
    }
}

struct SkeletonRow: View {
    
    private var placeholderString = "*************************************"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                    .mask {
                        Circle()
                            .frame(width: 60, height: 60, alignment: .leading)
                            .redectedAnimation()
                    }
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 8) {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                            .frame(maxWidth: .infinity, maxHeight: 12.5)
                        
                        Text(placeholderString)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .redacted(reason: .placeholder)
                            .redectedAnimation()
                            .background(Color.clear)
                            .lineLimit(1)
                    }
                    
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                            .frame(maxWidth: .infinity, maxHeight: 12.5)
                        
                        Text(placeholderString)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .redacted(reason: .placeholder)
                            .redectedAnimation()
                            .background(Color.clear)
                            .lineLimit(1)
                    }
                }
            }
        }
    }
}


#Preview {
    SkeletonView()
}
