//
//  Tools.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 05/02/2021.
//

import Foundation

struct Tools {
    static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.positiveFormat = "#,##0 ¤"
        return formatter
    }()
}
