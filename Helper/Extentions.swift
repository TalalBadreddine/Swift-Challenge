//
//  Extentions.swift
//  Swift-Challenge
//
//  Created by Talal Badreddine on 02/12/2021.
//

import Foundation
import UIKit

// MARK: regex for email validating
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
// MARK: Animations
extension UIView {
    
    func blink() {

        let blink = CABasicAnimation(keyPath: "opacity")
        blink.duration = 0.5
        blink.fromValue = 1
        blink.toValue = 0.1
        blink.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        blink.autoreverses = true
        blink.repeatCount = 3

        layer.add(blink, forKey: nil)
    }
}

// MARK: UIVIewController
extension UIViewController {
    
    func showMessagePrompt(_ message: String) {
      let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      present(alert, animated: false, completion: nil)
    }
    
}
