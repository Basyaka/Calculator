//
//  UIColorExtension.swift
//  Calculator
//
//  Created by Vlad Novik on 8.02.21.
//

import UIKit

extension UIColor {
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.1 * r + 0.5 * g + 0.03 * b
        return lum < 0.50
    }
}
