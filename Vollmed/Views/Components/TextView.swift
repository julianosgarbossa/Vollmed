//
//  LabelView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 22/07/25.
//

import SwiftUI

struct TextView: View {
    
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title3)
            .bold()
            .foregroundStyle(.accent)
    }
}

#Preview {
    TextView(text: "Nome")
}
