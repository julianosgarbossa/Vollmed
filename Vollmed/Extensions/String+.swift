//
//  String+.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 17/07/25.
//

import Foundation

extension String {
    func convertDateStringToReadableDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = inputFormatter.date(from: self) else {
            return ""
        }
        inputFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return inputFormatter.string(from: date)
    }
}
