//
//  String+htmlEscaped.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation
import UIKit


extension String {
    func htmlEscaped(font: UIFont, colorHex: String, lineSpacing: CGFloat,textAlignment:NSTextAlignment) -> NSAttributedString {
        let style = """
                    <style>
                    p.normal {
                      text-align:\((textAlignment == .center) ? "center":"left");
                      line-height: \(lineSpacing);
                      font-size: \(font.pointSize)px;
                      font-family: \(font.familyName);
                      color: \(colorHex);
                    }
                    </style>
        """
        let modified = String(format:"\(style)<p class=normal>%@</p>", self)
        if let data = modified.data(using: .unicode), let attributed = try? NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil) {
            return attributed
        }
        return NSAttributedString(string: self)
    }
}
