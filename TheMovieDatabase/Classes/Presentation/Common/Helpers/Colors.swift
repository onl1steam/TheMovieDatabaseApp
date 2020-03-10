//
//  Color.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

enum Colors {
    static let backgroundBlack = UIColor(named: ColorNames.backgroundBlack)!
    static let darkBlue = UIColor(named: ColorNames.darkBlue)!
    static let gray = UIColor(named: ColorNames.gray)!
    static let green = UIColor(named: ColorNames.green)!
    static let light = UIColor(named: ColorNames.light)!
    static let orange = UIColor(named: ColorNames.orange)!
    static let purpure = UIColor(named: ColorNames.purpure)!
    static let red = UIColor(named: ColorNames.red)!
    static let yellow = UIColor(named: ColorNames.yellow)!
    static let tabBarBackground = UIColor(named: ColorNames.tabBarBackground)!
    static let disabledButtonBackground = UIColor(named: ColorNames.disabledButtonBackground)!
    static let disabledButtonText = UIColor(named: ColorNames.disabledButtonText)!
    
    private enum ColorNames {
        static let backgroundBlack = "bg_black"
        static let darkBlue = "Dark_blue"
        static let gray = "Gray"
        static let green = "Green"
        static let light = "Light"
        static let orange = "Orange"
        static let purpure = "Purpure"
        static let red = "Red"
        static let yellow = "Yellow"
        static let tabBarBackground = "TabBar_bg"
        static let disabledButtonBackground = "Dark_blue_button"
        static let disabledButtonText = "Dark_blue_button_text"
    }
}
