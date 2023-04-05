//
//  UIKitExtensions.swift
//  FoodApp
//
//  Created by G on 05.04.2023.
//

import UIKit

extension UILabel {
    func addTrailing(image: UIImage?) {
        guard let image = image, let text = self.text else { return }
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

