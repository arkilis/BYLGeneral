//
//  UIColor+Util.swift
//  Days Count
//
//  Created by Ben Liu on 20/4/21.
//

import UIKit
import SwiftUI

public extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}

@available(iOS 13.0, *)
public extension Color {
  
  init(hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 08) & 0xff) / 255,
      blue: Double((hex >> 00) & 0xff) / 255,
      opacity: alpha
    )
  }
  
  var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
    #if canImport(UIKit)
    typealias NativeColor = UIColor
    #elseif canImport(AppKit)
    typealias NativeColor = NSColor
    #endif
    
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var o: CGFloat = 0
    
    if #available(iOS 14.0, *) {
      guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
        // You can handle the failure here as you want
        return (0, 0, 0, 0)
      }
    } else {
      // Fallback on earlier versions
    }
    return (r, g, b, o)
  }
  
  func getShadeColor(degree: CGFloat, alpha: Double = 1) -> Color {
    if (degree < 0.0 || degree >= 1.0) {
      return self
    }
    let shadeRed = self.components.red * (1-degree)
    let shadeGreen = self.components.green * (1-degree)
    let shadeBlue = self.components.blue * (1-degree)
    return Color(.sRGB, red: Double(shadeRed), green: Double(shadeGreen), blue: Double(shadeBlue), opacity: alpha)
  }
  
  func getTintColor(degree: CGFloat, alpha: Double = 1) -> Color {
    if (degree < 0.0 || degree >= 1.0) {
      return self
    }
    let tintRed = self.components.red + (1.0 - self.components.red) * degree
    let tintGreen = self.components.green + (1.0 - self.components.green) * degree
    let tintBlue = self.components.blue + (1.0 - self.components.blue) * degree
    return Color(.sRGB, red: Double(tintRed), green: Double(tintGreen), blue: Double(tintBlue), opacity: alpha)
  }
  
}
