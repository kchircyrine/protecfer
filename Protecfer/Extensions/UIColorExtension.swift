//
//  UIColorExtension.swift
//  LeituraDeBolso
//
//  Copyright © 2016 Lab262. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    //Pragma MARK : - Functions
    class func colorWithHexString(_ hex:String) -> UIColor {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    public func hexString(_ includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    class func getColorWithNameFromUserDefaults(_ colorName: String) -> UIColor {
        
        if let color = UserDefaults.standard.object(forKey: colorName) as? UIColor{
            return color
        } else {
            return .white
        }
    }
    

    //Pragma MARK : - Constants

    
    class func readingPurpleColor()->UIColor{
        return colorWithHexString("632686")
    }
    
    class func readingModeNightBackground () -> UIColor {
        return colorWithHexString("190126")
    }
   
    class func readingBlueColor()->UIColor{
        return colorWithHexString("1BDBAD")
        
    }

    class var backgroundColor: UIColor {
        get {
            return getColorWithNameFromUserDefaults("backgroundColor")
        }
        set {
            let hexString = newValue.hexString(true)
             UserDefaults.standard.set(hexString, forKey: "backgroundColor")
        }
    }
    
    
    
    
    
}
