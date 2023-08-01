//
//  App+Extensions.swift
//  Demo Project
//
//  Created by Apple on 14/07/22.
//

import Foundation
import UIKit


extension UIViewController {
    var isDarkMode: UIUserInterfaceStyle {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle
        } else {
            return self.traitCollection.userInterfaceStyle
        }
    }
    
}

extension Date {
    var is18yearsOld:Bool {
        return (Date().yearsFrom(date: self) > 18)
    }
    func yearsFrom(date:Date) -> Int
    {
        let age = Calendar.current.dateComponents([.year], from: date, to: self).year!
        print(age)
        return age
    }
}

extension UIStoryboard {
    
    class viewController {
        
        // MARK: - Static Storyboard Instances
        
        private let mainStoryBoard = UIStoryboard(name:"Main", bundle:nil)
        
      //  private let contestStoryBoard = UIStoryboard(name:"Contest", bundle:nil)
        
   //     private let authenticateStoryboard = UIStoryboard(name: "Authenticate", bundle: nil)
    //    private let resetPasswordController = UIStoryboard(name: "ResetPasswordViewController", bundle: nil)
    //    private let gcAlert = UIStoryboard(name: "GCAlert", bundle: nil)
        // MARK: - View Controllers
        
        func resetPass() -> ResetPasswordViewController {
            return mainStoryBoard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        }
        
        func signinScene() -> LoginViewController {
            
            return mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
        }
        
        func signUpScene() -> ViewController {
            
            return mainStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! ViewController
            
        }
        
        func homeScene() -> HomeViewController {
            
            return mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
        }
        
        func notificationsScene() -> NotificationsViewController {
            
            return mainStoryBoard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
            
        }
        
        func settingsScene() -> SettingsViewController {
            
            return mainStoryBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            
        }
        

    }
}

public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            switch identifier {
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "1"  // "iPhone 4"
            case "iPhone4,1":                               return "2"  // "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "3"  // "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "4"  // "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "5"  // "iPhone 5s"
            case "iPhone7,2":                               return "6"  // "iPhone 6"
            case "iPhone7,1":                               return "7"  // "iPhone 6 Plus"
            case "iPhone8,1":                               return "8"  // "iPhone 6s"
            case "iPhone8,2":                               return "9"  // "iPhone 6s Plus"
            case "iPhone8,4":                               return "10" // "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "11" // "iPhone 7" 11
            case "iPhone9,2", "iPhone9,4":                  return "12" // "iPhone 7 Plus" 12
            case "iPhone10,1", "iPhone10,4":                return "13" // "iPhone 8" 13
            case "iPhone10,2", "iPhone10,5":                return "14" // "iPhone 8 Plus" 14
            case "iPhone10,3", "iPhone10,6":                return "15" // "iPhone X" 15
            case "iPhone11,2":                              return "16" // "iPhone XS" 16
            case "iPhone11,4", "iPhone11,6":                return "17" // "iPhone XS Max" 17
            case "iPhone11,8":                              return "18" // "iPhone XR" 18
            case "iPhone12,1":                              return "19" // "iPhone 11" 19
            case "iPhone12,3":                              return "20" // "iPhone 11 Pro" 20
            case "iPhone12,5":                              return "21" // "iPhone 11 Pro Max" 21
            case "iPhone12,8":                              return "22" // "iPhone SE (2nd generation)" 22
            case "iPhone13,1":                              return "23" // "iPhone 12 mini" 23
            case "iPhone13,2":                              return "24" // "iPhone 12" 24
            case "iPhone13,3":                              return "25" // "iPhone 12 Pro" 25
            case "iPhone13,4":                              return "26" // "iPhone 12 Pro Max" 26
            case "i386", "x86_64":                          return "27" // "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))" 27
            default:                                        return identifier
            }
        }
        
        return mapToDevice(identifier: identifier)
    }()
}

extension UIDevice {
    static func getDeviceID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}




