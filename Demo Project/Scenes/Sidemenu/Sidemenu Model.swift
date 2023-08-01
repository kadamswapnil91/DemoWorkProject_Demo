//
//  Sidemenu Model.swift
//  Demo Project
//
//  Created by Apple on 14/07/22.
//

import Foundation
import UIKit

struct SideMenuOptions {
    let title: String
    let icon: UIImage
    var notificationCount: Int? = nil
    let type: MenuType
}

enum MenuType: Int {
    case home = 0, notificatio, setting, referApp, rateUs, logout
}
