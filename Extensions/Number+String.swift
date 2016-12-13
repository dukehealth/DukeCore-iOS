//
//  Double+String.swift
//  apple
//
//  Created by Mike Revoir on 3/2/16.
//  Copyright © 2016 Duke Institute for Health Innovation. All rights reserved.
//

import Foundation

struct MyNumberFormatter {
    static let DecimalStyleFormatter: NumberFormatter = {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var decimalStyleString: String {
        return MyNumberFormatter.DecimalStyleFormatter.string(from: self as NSNumber) ?? ""
    }
}

extension Double {
    var decimalStyleString: String {
        return MyNumberFormatter.DecimalStyleFormatter.string(from: self as NSNumber) ?? ""
    }
}

extension Float {
    var decimalStyleString: String {
        return MyNumberFormatter.DecimalStyleFormatter.string(from: self as NSNumber) ?? ""
    }
}
