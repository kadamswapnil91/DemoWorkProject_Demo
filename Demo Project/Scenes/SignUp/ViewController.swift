//
//  ViewController.swift
//  Demo Project
//
//  Created by Apple on 16/06/22.
//
import UIKit
import Firebase
import FirebaseAuth
import IQKeyboardManagerSwift

class FirebaseAuthManager {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txt_mobileNo: UITextField!
    @IBOutlet weak var txt_confirmpassword: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_fullname: UITextField!
    @IBOutlet weak var lbl_signUp: UILabel!
    @IBOutlet weak var btn_signUp: UIButton!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_resetPassword: UIButton!
    @IBOutlet weak var btn_checkbox: UIButton!
    @IBOutlet weak var btn_eye_password: UIButton!
    @IBOutlet weak var btn_eyeconFirm: UIButton!
    var iconClick = true
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        ButtonsUI()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        let device_id = UIDevice.getDeviceID()
        print(device_id)
        
    }
    
    func ButtonsUI(){
        btn_signUp.layer.cornerRadius = 15
        btn_signUp.clipsToBounds = true
        btn_signUp.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn_signUp.layer.shadowColor = UIColor.lightGray.cgColor
        btn_signUp.layer.shadowOpacity = 1
        btn_signUp.layer.shadowRadius = 5
        btn_signUp.layer.masksToBounds = false
        
    }
    
    // MARK: - Actions
    
    @IBAction func btn_resetPassClick(_ sender: Any) {
        print("Reset Password Tapped")
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        navigationController?.pushViewController(UIStoryboard.viewController().resetPass(), animated: false)
       
    }
    
    @IBAction func checkboxselectedTapped(_ sender: Any) {
        btn_checkbox.isSelected = !btn_checkbox.isSelected
      /*  if btn_checkbox.isSelected
        {
            btn_checkbox.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            btn_checkbox.isSelected = false;
        }
        else
        {
            btn_checkbox.setBackgroundImage(UIImage(named: "Check_box"), for: UIControl.State.normal)
            btn_checkbox.isSelected = true
            
        }*/
    }
    
    @IBAction func btn_eyeConfirm(_ sender: Any) {
        if iconClick == true {
            txt_confirmpassword.isSecureTextEntry = false
        }else
        {
            txt_confirmpassword.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func btn_eyePass(_ sender: Any) {
        if iconClick == true {
            txt_password.isSecureTextEntry = false
        }else
        {
            txt_password.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func btn_loginClick(_ sender: Any) {
        print("Login Tapped")
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func Act_SignUp(_ sender: Any) {
        //Sign Up Action for email
        //        if txt_email.text == "" || txt_fullname.text == "" || txt_password.text == "" || txt_confirmpassword.text == "" || txt_mobileNo.text == "" {
        //            let alertController = UIAlertController(title: "Error", message: "Please enter your all Details!!!", preferredStyle: .alert)
        //
        //            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //            alertController.addAction(defaultAction)
        //
        //            present(alertController, animated: true, completion: nil)
        
        
        // new code
        
        if let email = txt_email.text, let password = txt_password.text, let username = txt_fullname.text, let conPassword = txt_confirmpassword.text, let mob = txt_mobileNo.text{
            if username == ""{
                print("Please enter Full Name...")
                openAlert(title: "Alert", message: "Please enter Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            }else if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Please enter valid Email id...", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("email is not valid")
            }else if !password.isValidPasswordBallchalu(){
                print("Password is not valid")
                print(txt_password.text as Any)
                openAlert(title: "Alert", message: "Please enter password with Minimum 7 characters", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            }
            else if mob.isValidPhone(){
                openAlert(title: "Alert", message: "Please enter Valid mobile number ", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            }
            else {
                if conPassword == ""{
                    print("Please confirm password")
                    openAlert(title: "Alert", message: "Please enter Confirm password ", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                }
                else{
                    if password == conPassword && btn_checkbox.isSelected == true {
                        // navigation code
                        print("Navigation code Yeah!")
                        
                        Auth.auth().createUser(withEmail: txt_email.text!, password: txt_password.text!) { (user, error) in
                            
                            if error == nil {
                                print("You have successfully signed up")
                                
//
//                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                                self.navigationController?.pushViewController(nextViewController, animated: true)
                                self.navigationController?.pushViewController(UIStoryboard.viewController().homeScene(), animated: false)
                                
                            } else {
                                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                                
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        
                    }else{
                        print("password does not match")
                        openAlert(title: "Alert", message: "Please accepct terms & conditions ", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    }
                }
            }
        }else{
            print("Please check your details")
            openAlert(title: "Alert", message: "Check your details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
    }
    
    
    //        else {
    //            Auth.auth().createUser(withEmail: txt_email.text!, password: txt_password.text!) { (user, error) in
    //
    //                if error == nil {
    //                    print("You have successfully signed up")
    //
    //                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
    //                    self.present(vc!, animated: true, completion: nil)
    //
    //                } else {
    //                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
    //
    //                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    //                    alertController.addAction(defaultAction)
    //
    //                    self.present(alertController, animated: true, completion: nil)
    //                }
    //            }
    //        }
    //   }
}







