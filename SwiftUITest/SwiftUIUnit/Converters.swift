//
//  Converters.swift
//  SwiftUIUnit
//
//  Created by TCH Developer on 18/11/2022.
//

import Foundation

class Converters {
    func convertEuroToUSD(euro: String) -> String {
        // Hard coding for now
        let usdRate = 1.08
        let euroValue = Double(euro) ?? 0
        
        if euroValue <= 0 {
            return "Please enter a positive number"
        }
        
        if euroValue >= 1_000_000 {
            return "Value too large to convert"
        }
        
        return "$\(String(format: "%.2f", euroValue * usdRate))"
    }
}
