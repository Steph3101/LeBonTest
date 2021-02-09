//
//  Font.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 09/02/2021.
//

import Foundation
import UIKit

struct Font {
    static var defaultFontSize: CGFloat = 15.0

    static var thin: UIFont { return UIFont(name:"AirbnbCerealApp-Light", size: defaultFontSize)! }
    static var light: UIFont { return UIFont(name:"AirbnbCerealApp-Book", size: defaultFontSize)! }
    static var medium: UIFont { return UIFont(name:"AirbnbCerealApp-Medium", size: defaultFontSize)! }
    static var bold: UIFont { return UIFont(name:"AirbnbCerealApp-Bold", size: defaultFontSize)! }
    static var extraBold: UIFont { return UIFont(name:"AirbnbCerealApp-ExtraBold", size: defaultFontSize)! }
    static var black: UIFont { return UIFont(name:"AirbnbCerealApp-Black", size: defaultFontSize)! }
}
