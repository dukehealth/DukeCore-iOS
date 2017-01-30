//
//  UIColor+Utility.swift
//
//  Copyright © 2017 Duke Institute for Health Innovation. All rights reserved.
//

import UIKit

extension UIColor {
    // From http://crunchybagel.com/working-with-hex-colors-in-swift-3/
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static var dukeBlue: UIColor {
        return UIColor(hex: "001A57")
    }
    static var dukeBlueLight: UIColor {
        return UIColor(hex: "003366")
    }
    static var dukeBrightBlue: UIColor {
        return UIColor(hex: "0736A4")
    }
    static var dukeCadetBlue: UIColor {
        return UIColor(hex: "235F9C")
    }
    static var dukeSkyBlue: UIColor {
        return UIColor(hex: "0680CD")
    }
    static var dukeTealBlue: UIColor {
        return UIColor(hex: "339999")
    }
    static var dukePurple: UIColor {
        return UIColor(hex: "993399")
    }
    static var dukeGreen: UIColor {
        return UIColor(hex: "728302")
    }
    static var dukePaleGreen: UIColor {
        return UIColor(hex: "EBF0CC")
    }
    static var dukeBrightGreen: UIColor {
        return UIColor(hex: "A1B70D")
    }
    static var dukeRed: UIColor {
        return UIColor(hex: "CC3300")
    }
    static var dukeYellow: UIColor {
        return UIColor(hex: "FFD960")
    }
    static var dukePaleYellow: UIColor {
        return UIColor(hex: "F6EAB8")
    }
    static var dukeOrange: UIColor {
        return UIColor(hex: "D75404")
    }
    static var dukeBrown: UIColor {
        return UIColor(hex: "8D8D8D")
    }
    static var dukeLightBrown: UIColor {
        return UIColor(hex: "8D8D8D")
    }
    static var dukeBlack: UIColor {
        return UIColor(hex: "8D8D8D")
    }
    static var dukeCoolGray: UIColor {
        return UIColor(hex: "8D8D8D")
    }
    static var dukeLightGray: UIColor {
        return UIColor(hex: "8D8D8D")
    }
    static var dukePaleGray: UIColor {
        return UIColor(hex: "8D8D8D")
    }

    static var dukeHealthBlue: UIColor {
        return UIColor(hex: "00539B")
    }
    static var dukeHealthBlack: UIColor {
        return UIColor(hex: "58595B")
    }
    static var dukeHealthGray: UIColor {
        return UIColor(hex: "808285")
    }
    static var dukeHealthLightGray: UIColor {
        return UIColor(hex: "BCBEC0")
    }
    static var dukeHealthPaleGray: UIColor {
        return UIColor(hex: "E6E7E8")
    }
    static var dukeHealthGreen: UIColor {
        return UIColor(hex: "B1B951")
    }
    static var dukeHealthYellow: UIColor {
        return UIColor(hex: "F6C867")
    }
    static var dukeHealthOrange: UIColor {
        return UIColor(hex: "F28521")
    }
    static var dukeHealthRed: UIColor {
        return UIColor(hex: "DC4A38")
    }
    static var dukeHealthSkyBlue: UIColor {
        return UIColor(hex: "4FA3C7")
    }
}
