//
//  UIColor.swift
//  previously Color+HexAndCSSColorNames.swift
//
//  Created by Norman Basham on 12/8/15.
//  Copyright ©2018 Black Labs. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
import UIKit

extension UIColor {
    /**
     Returns a hex equivalent of this UIColor.
     - Parameter includeAlpha:   Optional parameter to include the alpha hex.
     color.hexDescription() -> "ff0000"
     color.hexDescription(true) -> "ff0000aa"
     - Returns: A new string with `String` with the color's hexidecimal value.
     */
    func hexDescription(_ includeAlpha: Bool = false) -> String {
        guard self.cgColor.numberOfComponents == 4 ||  self.cgColor.numberOfComponents == 2 else {
            return "Color not RGB or Gray."
        }
        if self.cgColor.numberOfComponents == 4 {
            let a = self.cgColor.components!.map { Int($0 * CGFloat(255)) }
            let color = String.init(format: "%02x%02x%02x", a[0], a[1], a[2])
            if includeAlpha {
                let alpha = String.init(format: "%02x", a[3])
                return "\(color)\(alpha)"
            }
            return color
        }
        // components is 2
        let a = self.cgColor.components!.map { Int($0 * CGFloat(255)) }
        let color = String.init(format: "%02x%02x%02x", a[0], a[0], a[0])
        if includeAlpha {
            let alpha = String.init(format: "%02x", a[1])
            return "\(color)\(alpha)"
        }
        return color
    }
}
