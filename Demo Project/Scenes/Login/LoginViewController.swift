//
//  LoginViewController.swift
//  Demo Project
//
//  Created by Apple on 17/06/22.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import IQKeyboardManagerSwift
//import FacebookLogin
class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var btn_facebook: FBLoginButton!
    @IBOutlet weak var lbl_signUp: UILabel!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_signUp: UIButton!
    @IBOutlet weak var btn_resetPassword: UIButton!
    @IBOutlet weak var btn_eyepass: UIButton!
    @IBOutlet weak var btn_AppleLogin: UIButton!
    @IBOutlet weak var btn_Googlelogin: UIButton!
    var iconClick = true
    var profileGoogle: GIDProfileData?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        facebookLogin()
        googleLogin()
        UserLoogedIn()
        ButtonsUI()
        print(profileGoogle?.email as Any)
        self.hideKeyboardWhenTappedAround()
    }
    
    func setBottomBorderToTextFields()  {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: txt_email.frame.height - 1, width: txt_email.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor // background color
        txt_email.borderStyle = UITextBorderStyle.none // border style
        txt_email.layer.addSublayer(bottomLine)
        
        bottomLine.frame = CGRect(x: 0, y: txt_password.frame.height - 1, width: txt_password.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor // background color
        txt_password.borderStyle = UITextBorderStyle.none // border style
        txt_password.layer.addSublayer(bottomLine)
    }
    
    func ButtonsUI(){
        btn_login.layer.cornerRadius = 15
        btn_login.clipsToBounds = true
        
        btn_facebook.layer.cornerRadius = 15
        btn_facebook.clipsToBounds = true
        
        btn_Googlelogin.layer.cornerRadius = 15
        btn_Googlelogin.clipsToBounds = true
        
        btn_login.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_login.layer.shadowColor = UIColor.lightGray.cgColor
        btn_login.layer.shadowOpacity = 1
        btn_login.layer.shadowRadius = 5
        btn_login.layer.masksToBounds = false
        
        btn_facebook.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_facebook.layer.shadowColor = UIColor.lightGray.cgColor
        btn_facebook.layer.shadowOpacity = 1
        btn_facebook.layer.shadowRadius = 5
        btn_facebook.layer.masksToBounds = true
        
        btn_Googlelogin.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_Googlelogin.layer.shadowColor = UIColor.lightGray.cgColor
        btn_Googlelogin.layer.shadowOpacity = 1
        btn_Googlelogin.layer.shadowRadius = 5
        btn_Googlelogin.layer.masksToBounds = true
        
    }
    
    func UserLoogedIn(){
        // check user is logged in throug firebase
        GIDSignIn.sharedInstance().signInSilently()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                if UserDefaults.standard.string(forKey: "uid") != nil && Auth.auth().currentUser != nil {
                    //User was already logged in
                    print("User already Logged in")
                }
                UserDefaults.standard.setValue(user?.uid, forKeyPath: "uid")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
        }
    }
    
    
    func googleLogin(){
    // This function used to check google User is already logged in or not
    }
    
    func facebookLogin(){
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result)")
                print("*********User already login ************")
                self.navigationController?.pushViewController(UIStoryboard.viewController().homeScene(), animated: false)
            }
        }else{
            btn_facebook.permissions = ["public_profile", "email"]
            btn_facebook.delegate = self
        }
    }
    
    // MARK: - Actions
    
    @IBAction func appleLoginTapped(_ sender: UIButton) {
        print("************* Apple Login Tapped ******************")
    }
    @IBAction func loginWithgooleTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.signIn()

        
    }
    
    @IBAction func btn_eyepassClick(_ sender: Any) {
        if iconClick == true {
            txt_password.isSecureTextEntry = false
        }else
        {
            txt_password.isSecureTextEntry = true
        }
        iconClick = !iconClick
        
    }
    
    @IBAction func Act_loginClick(_ sender: Any) {
        if self.txt_email.text == "" || self.txt_password.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.txt_email.text!, password: self.txt_password.text!) { (user, error) in
                
                if error == nil {
                    let userEmail = Auth.auth().currentUser?.email
                    print("User logged in through Manual sign in User Email is >>>>>>>>>>>>>>>>", userEmail!)

                    self.navigationController?.pushViewController(UIStoryboard.viewController().homeScene(), animated: false)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func act_SignUpClick(_ sender: Any) {
        print("Sign up Tapped")
        navigationController?.pushViewController(UIStoryboard.viewController().signUpScene(), animated: true)
        
    }
    

    @IBAction func facebook_Tapped(_ sender: FBLoginButton) {
        print("*********Facebook Tapped ************")


     //   navigationController?.pushViewController(UIStoryboard.viewController().homeScene(), animated: false)
    }
    
    
    @IBAction func act_resetPassClick(_ sender: Any) {
        print("Reset/Forgot password Tapped")

        navigationController?.pushViewController(UIStoryboard.viewController().resetPass(), animated: false)
        
    }
    
}

extension LoginViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result)")
        }
        navigationController?.pushViewController(UIStoryboard.viewController().homeScene(), animated: false)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}

extension LoginViewController{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("We have error sign in user == \(error.localizedDescription)")
        } else {
            if let gmailUser = user {
                let GName = gmailUser.profile.name
                let GFamilyName = gmailUser.profile.familyName
                let GGivenName = gmailUser.profile.givenName
                let Ghashimg = gmailUser.profile.hasImage
                let Gimage = gmailUser.profile.imageURL(withDimension: 100)
                let GProfile = gmailUser.profile
                print(GName as Any, GFamilyName as Any, GGivenName as Any, Ghashimg as Any, Gimage as Any, GProfile as Any)
                if (gmailUser.profile.hasImage) {
                    let url = user.profile.imageURL(withDimension: 100)
                    print("url....\(String(describing: url))")
                }
                if GName == nil{
                    print("***********User not logged**********")
                }
                else{
                    print("*********User login successfull************")


                    navigationController?.pushViewController(UIStoryboard.viewController().homeScene(), animated: false)
                    
                }
                
            }
        }
    }
}



