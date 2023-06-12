//
//  Constants.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 09/06/2023.
//

import Foundation
import UIKit
enum Constants {
    enum Color {
        static let yellow: UIColor = #colorLiteral(red: 1.00, green: 0.80, blue: 0.17, alpha: 1.00)
        static let white: UIColor  = #colorLiteral(red: 1.00, green: 1.0, blue: 1.0, alpha: 1.00)
        static let white2: UIColor  = #colorLiteral(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        static let red: UIColor =  #colorLiteral(red: 0.88, green: 0.30, blue: 0.27, alpha: 1.00)
        static let lightGray: UIColor =  #colorLiteral(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.00)
    }
    enum Font {
        static let smallBold: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        static let regularBold: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        static let bigBold: UIFont = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        static let regular: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
    }
    enum Pading {
        static let smallPadding: CGFloat = 8
        static let regularPadding: CGFloat = 2 * Constants.Pading.smallPadding
        static let bigPadding: CGFloat = 4 * Constants.Pading.smallPadding
    }
    enum UserInterface {
        static let titleBgOpacity: Float = 0.8
        static let titleComponentHeight: CGFloat = 85.0
        static let basketCompomentHeight: CGFloat = 30.0
        static let cornerRadius: CGFloat = 5
    }
}
