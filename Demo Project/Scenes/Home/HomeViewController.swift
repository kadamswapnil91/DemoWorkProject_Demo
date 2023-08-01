//
//  HomeViewController.swift
//  Demo Project
//
//  Created by Apple on 17/06/22.
//

import UIKit
import SideMenu
import GoogleSignIn
import Firebase
import IQKeyboardManagerSwift
import FBSDKLoginKit

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lbl_Home: UILabel!
    @IBOutlet weak var btn_Logout: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationController?.isNavigationBarHidden = false
        setupSideMenu()
        updateUI(settings: SideMenuSettings())
        self.hideKeyboardWhenTappedAround()
        ButtonsUI()
//        open var menuPresentMode: SideMenuManager.MenuPresentMode = .viewSlideOut
//        SideMenuManager.MenuPresentMode = .vi
     //   SideMenuManager.default.menuPresentMode = .menuSlideIn     // depricated
    //    SideMenuNavigationControl
     //   sideMenuSet.presentationStyle = .menuSlideIn
        
        
        
    }
    
    func makeSettings() -> SideMenuSettings{
    var settings = SideMenuSettings()
    settings.allowPushOfSameClassTwice = false
    settings.presentationStyle = .menuSlideIn
    settings.statusBarEndAlpha = 0
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let height = screenBounds.height
        
        settings.menuWidth = width/1.4
    return settings}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings = makeSettings()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func ButtonsUI(){
        btn_Logout.layer.cornerRadius = 15
        btn_Logout.clipsToBounds = true
        
        btn_Logout.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_Logout.layer.shadowColor = UIColor.lightGray.cgColor
        btn_Logout.layer.shadowOpacity = 1
        btn_Logout.layer.shadowRadius = 5
        btn_Logout.layer.masksToBounds = false
    }
    
    private func setupSideMenu() {
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        self.navigationController?.isNavigationBarHidden = false
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    private func updateUI(settings: SideMenuSettings) {
        let styles:[UIBlurEffect.Style] = [.dark, .light, .extraLight]
        if let menuBlurEffectStyle = settings.blurEffectStyle {
            
        } else {
            
        }
        
    }
    
    @IBAction func btn_logOutclick(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
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
        
        
    }
    
}
// MARK: - SidemenuExtension
extension HomeViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
        self.navigationController?.isNavigationBarHidden = false
    }
}


