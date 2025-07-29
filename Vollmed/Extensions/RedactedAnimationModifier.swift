//
//  RedactedAnimationModifier.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 29/07/25.
//

import SwiftUI

struct RedactedAnimationModifier: ViewModifier {
    
    @State private var isRedacted: Bool = true
    
    func body(content: Content) -> some View {
        content
            .opacity(isRedacted ? 0.4 : 0.7)
            .onAppear() {
                withAnimation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                    self.isRedacted.toggle()
                }
            }
    }
}

extension View {
    func redectedAnimation() -> some View {
        modifier(RedactedAnimationModifier())
    }
}
