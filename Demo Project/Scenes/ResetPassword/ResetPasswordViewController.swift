//
//  ResetPasswordViewController.swift
//  Demo Project
//
//  Created by Apple on 17/06/22.
//

import UIKit
import IQKeyboardManagerSwift

class ResetPasswordViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btn_signIn: UIButton!
    @IBOutlet weak var btn_resetPassword: UIButton!
    @IBOutlet weak var btn_signUp: UIButton!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var lbl_resetPassword: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
        ButtonsUI()
    }
    
    func ButtonsUI(){
        btn_resetPassword.layer.cornerRadius = 15
        btn_resetPassword.clipsToBounds = true
        
        btn_signIn.layer.cornerRadius = 15
        btn_signIn.clipsToBounds = true
        
        btn_signUp.layer.cornerRadius = 15
        btn_signUp.clipsToBounds = true
        
        btn_resetPassword.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_resetPassword.layer.shadowColor = UIColor.lightGray.cgColor
        btn_resetPassword.layer.shadowOpacity = 1
        btn_resetPassword.layer.shadowRadius = 5
        btn_resetPassword.layer.masksToBounds = false
        
        btn_signIn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_signIn.layer.shadowColor = UIColor.lightGray.cgColor
        btn_signIn.layer.shadowOpacity = 1
        btn_signIn.layer.shadowRadius = 5
        btn_signIn.layer.masksToBounds = false
        
        btn_signUp.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_signUp.layer.shadowColor = UIColor.lightGray.cgColor
        btn_signUp.layer.shadowOpacity = 1
        btn_signUp.layer.shadowRadius = 5
        btn_signUp.layer.masksToBounds = false
        
    }
    
    
    // MARK: - Actions
    @IBAction func resetPassClicked(_ sender: Any) {
        // User will gets reset password mail
        print("Reset password button clicked")
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print("Login Button clicked")
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        navigationController?.pushViewController(UIStoryboard.viewController().signinScene(), animated: false)
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        print("sign up clicked")
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as!ViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        navigationController?.pushViewController(UIStoryboard.viewController().signUpScene(), animated: false)
    }
    
}
