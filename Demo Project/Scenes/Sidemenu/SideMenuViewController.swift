//
//  SideMenuViewController.swift
//  Demo Project
//
//  Created by Apple on 26/06/22.
//

import UIKit
import GoogleSignIn
//import SDWebImage
import Kingfisher
import IQKeyboardManagerSwift
import SideMenu
import Firebase
import FBSDKLoginKit


class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var imgProfileimg: UIImageView!
    @IBOutlet weak var lbl_fullName: UILabel!
    @IBOutlet weak var lbl_EmailiD: UILabel!
    @IBOutlet weak var lbl_profession: UILabel!
    @IBOutlet weak var tableview: UITableView!

    
    var items: [SideMenuOptions] = [SideMenuOptions(title: "Home", icon: #imageLiteral(resourceName: "Icon ionic-md-home"), type: .home),SideMenuOptions(title: "Notifications", icon: #imageLiteral(resourceName: "Icon material-notifications-active"), type: .notificatio),SideMenuOptions(title: "Settings", icon: #imageLiteral(resourceName: "Icon ionic-ios-settings"), type: .setting),SideMenuOptions(title: "Refer App", icon: #imageLiteral(resourceName: "Icon ionic-md-share"), type: .referApp),SideMenuOptions(title: "Rate Us", icon: #imageLiteral(resourceName: "Icon metro-star-full"), type: .rateUs),SideMenuOptions(title: "Logout", icon: #imageLiteral(resourceName: "Icon feather-log-out"), type: .logout)]
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setuProfile()
        CheckUserLoggedGoogle()
        setUpfacebookProfile()
    }
    
    

    
    func CheckUserLoggedGoogle(){
        if(GIDSignIn.sharedInstance()?.currentUser != nil)
        {
            //loggedIn
            print("User Logged in already")
        }
        else
        {
            //not loggedIn
            print("User not Logged in !!!")
        }
    }
    
    func setuProfile() {
        let UEmail = GIDSignIn.sharedInstance().currentUser?.profile?.email
        let UName = GIDSignIn.sharedInstance().currentUser?.profile?.name
        let Uurl = GIDSignIn.sharedInstance()?.currentUser?.profile?.hasImage
        let U320 = GIDSignIn.sharedInstance().currentUser?.profile?.imageURL(withDimension: 320)
        print(">>>>>>>>>>>>",UEmail as Any)
        print(">>>>>>>>>>>>",UName as Any)
        print(">>>>>>>>>>>>",Uurl as Any)
        print(">>>>>>>>>>>>",U320 as Any)
        lbl_fullName.text = UName
        lbl_EmailiD.text = UEmail
        imgProfileimg.kf.setImage(with: U320)
        imgProfileimg?.layer.cornerRadius = (imgProfileimg?.frame.size.width ?? 0.0) / 2
        imgProfileimg?.clipsToBounds = true
        imgProfileimg?.layer.borderWidth = 3.0
        imgProfileimg?.layer.borderColor = UIColor.white.cgColor
    }
    
    func setUpfacebookProfile(){
        let token = AccessToken.current?.tokenString
        let params = ["fields": "first_name, last_name, email"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params, tokenString: token, version: nil, httpMethod: .get)
        graphRequest.start { [self] (connection, result, error) in

            if let err = error {
                print("Facebook graph request error: \(err)")
            } else {
                print("Facebook graph request successful!")

                guard let json = result as? NSDictionary else { return }
                if let email = json["email"] as? String {
                    print("\(email)")
                    lbl_EmailiD.text = email
                }
                if let firstName = json["first_name"] as? String {
                    print("\(firstName)")
                    lbl_fullName.text = firstName
                }
                if let lastName = json["last_name"] as? String {
                    print("\(lastName)")
                }
                if let id = json["id"] as? String {
                    print("\(id)")
                }
            }
        }
        
    }
    
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewTableViewCell
        // cell.lbl_settings.text = items[indexPath.row]
        // cell.img_images!.image = items[indexPath.row]
        
        let item = self.items[indexPath.row]
        cell.setContentData(image: item.icon, title: item.title, notificationCount: item.notificationCount)
        
        return cell;
    }
    
    private func shareAppURL() {
//                        UIGraphicsBeginImageContext(view.frame.size)
//                        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//                        let image = UIGraphicsGetImageFromCurrentImageContext()
//                        UIGraphicsEndImageContext()
//
//                        let textToShare = "Check out my app"
//
//                        if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
//                            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
//                            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//
//                            //Excluded Activities
//                            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
//                            //
//
//                        //    activityVC.popoverPresentationController?.sourceView = sender
//                            self.present(activityVC, animated: true, completion: nil)
//                        }    }
        
        print("App share pop up")
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
            let item = self.items[indexPath.row]
            NotificationCenter.default.post(name: NSNotification.Name("SideMenuItemDidTapped"), object: item.type.rawValue)

           
            switch item.type {
            case .setting:
                let setting = UIStoryboard.viewController().settingsScene()
                setting.modalPresentationStyle = .fullScreen
                self.present(setting, animated: true) {}
                
            case .referApp:
                self.shareAppURL()
            print("Refer cliced")
                
      //      case .seprator: break
            case .rateUs:
//                AppEvents.logEvent(.RateUsOpen)
//                let rateUS = UIStoryboard.viewController().alertView()
//                rateUS.descriptionStr = "Let us know what you think"
//                rateUS.titleStr = "Did you like this app?"
//                rateUS.type = .rateus
//                rateUS.btnTitle = "SUBMIT"
//                self.present(rateUS, animated: true) {}
            print("Rate us Tapped")
//            case .howToPlay:
//                let event = ["Complete tutorial" : "Success"]
//                AppEvents.logEvent(.HowToPlay, parameters: event)
//
//                let vc = UIStoryboard.viewController().introView()
//                vc.modalPresentationStyle = .fullScreen
//                vc.presentedBy = .sideMenu
//                vc.isHeroEnabled = false
//                self.present(vc, animated: true)
//                break
//            case .helpAndSupport:
//                let webViewController = UIStoryboard.viewController().gcWebViewController()
//                webViewController.modalPresentationStyle = .fullScreen
//                self.present(webViewController, animated: true) {
//                    webViewController.type = .helpAndSuport
//                }
//            case .aboutUs:
//                let webViewController = UIStoryboard.viewController().gcWebViewController()
//                webViewController.modalPresentationStyle = .fullScreen
//                self.present(webViewController, animated: true) {
//                    webViewController.type = .aboutUs
//                }
            case .logout:
                let refreshAlert = UIAlertController(title: "Demo App", message: "Are you sure you want to Logout?", preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                      print("Handle Ok logic here")
                            try! Auth.auth().signOut()
                            print("user sign out from firebase")
                            GIDSignIn.sharedInstance().signOut()
                            self.dismiss(animated: true, completion: nil)
                            print("user sign out from login with google")
                    
                    self.navigationController?.pushViewController(UIStoryboard.viewController().signinScene(), animated: false)
                    
                }))

                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                }))

                present(refreshAlert, animated: true, completion: nil)
 
            case .home:
                print("Home clicked")
            case .notificatio:
                print("notification count clicked")
                let Notification1 = UIStoryboard.viewController().notificationsScene()
                Notification1.modalPresentationStyle = .fullScreen
                self.present(Notification1, animated: true) {}
            }
               
//            default:
//                print(self.items[indexPath.row]);
//            }
        }
}
    
    
    
    



