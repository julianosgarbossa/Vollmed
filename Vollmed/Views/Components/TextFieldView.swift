//
//  TextFieldView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 22/07/25.
//

import SwiftUI

struct TextFieldView: View {
    
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var autocorrectionDisabled: Bool = true
    var textInputAutocapitalization: TextInputAutocapitalization = .never
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(14)
            .background(Color.gray.opacity(0.25))
            .clipShape(.rect(cornerRadius: 14))
            .autocorrectionDisabled(autocorrectionDisabled)
            .keyboardType(keyboardType)
            .textInputAutocapitalization(textInputAutocapitalization)
    }
}

#Preview {
    
    @Previewable @State var testText = "teste"
    
    TextFieldView(placeholder: "Insira um texto", text: $testText)
}
