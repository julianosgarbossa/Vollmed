//
//  SecureFieldView.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 22/07/25.
//

import SwiftUI

struct SecureFieldView: View {
    
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var autocorrectionDisabled: Bool = true
    var textInputAutocapitalization: TextInputAutocapitalization = .never
    
    var body: some View {
        SecureField("Insira sua senha", text: $text)
            .padding(14)
            .background(Color.gray.opacity(0.25))
            .clipShape(.rect(cornerRadius: 14))
            .autocorrectionDisabled(autocorrectionDisabled)
            .textInputAutocapitalization(textInputAutocapitalization)
            .keyboardType(keyboardType)
    }
}

#Preview {
    @Previewable @State var testText = "teste"
    
    SecureFieldView(placeholder: "teste", text: $testText)
}
