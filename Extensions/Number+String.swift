//
//  Double+String.swift
//  apple
//
//  Created by Mike Revoir on 3/2/16.
//  Copyright © 2016 Duke Institute for Health Innovation. All rights reserved.
//

import Foundation

struct Number {
    static let DecimalStyleFormatter: NSNumberFormatter = {
        let formatter: NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter
    }()
}

extension Int {
    var decimalStyleString: String {
        return Number.DecimalStyleFormatter.stringFromNumber(self) ?? ""
    }
}

extension Double {
    var decimalStyleString: String {
        return Number.DecimalStyleFormatter.stringFromNumber(self) ?? ""
    }
}

extension Float {
    var decimalStyleString: String {
        return Number.DecimalStyleFormatter.stringFromNumber(self) ?? ""
    }
}