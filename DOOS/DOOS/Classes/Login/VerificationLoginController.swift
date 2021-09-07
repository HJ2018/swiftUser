//
//  LoginController.swift
//  DOOS
//
//  Created by jie.huang on 13/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import IBAnimatable
import SVGKit
import IQKeyboardManagerSwift


class VerificationLoginController: UIViewController , UIViewControllerTransitioningDelegate {


    @IBOutlet weak var phoneNumberTextField: DoosTextFoeld!
    @IBOutlet weak var VerificationCodeTextField: DoosTextFoeld!
    @IBOutlet weak var logImageView: AnimatableImageView!
    @IBOutlet weak var LoginBtn: AnimatableButton!

    @IBOutlet weak var verificationCodeBtn: UIButton!
    
    var countdownTimer: Timer?
    
    var remainingSeconds: Int = 0 {
        willSet {
            verificationCodeBtn.setTitle("\(newValue)s", for: .normal)
            
            if newValue <= 0 {
                verificationCodeBtn.setTitle("获取验证码", for: .normal)
                isCounting = false
                
                verificationCodeBtn.isEnabled = true
                verificationCodeBtn.setTitleColor(UIColor.MainColor, for: .normal)
                verificationCodeBtn.layer.borderColor = UIColor.MainColor.cgColor
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime(_:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            verificationCodeBtn.setTitleColor(UIColor.EnabledColor, for: .normal)
            verificationCodeBtn.layer.borderColor = UIColor.EnabledColor.cgColor
            verificationCodeBtn.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         self.sh_interactivePopDisabled = true

        verificationCodeBtn.layer.borderWidth = 1
        verificationCodeBtn.layer.cornerRadius = 12

        
        _ = phoneNumberTextField.rx.text.orEmpty.map { (text) -> Bool in
            text.count >= 11
        }.share(replay: 1)
            .subscribe(onNext: { (valid) in
                
                if valid{
                    self.phoneNumberTextField.text = String(self.phoneNumberTextField!.text![..<self.phoneNumberTextField.text!.index(self.phoneNumberTextField!.text!.startIndex, offsetBy:11)])
                     IQKeyboardManager.shared.goNext()
                }
                self.verificationCodeBtnisEnabled(text: self.phoneNumberTextField.text ?? "")
                if PhoneNumberIsValidated(vStr: self.phoneNumberTextField.text ?? "") && self.VerificationCodeTextField.text?.count == 4{
                    self.LoginBtn.backgroundColor = UIColor.MainColor
                    self.LoginBtn.isEnabled = true
                    IQKeyboardManager.shared.resignFirstResponder()
                   
                }else{
                    self.LoginBtn.backgroundColor = UIColor.EnabledColor
                    self.LoginBtn.isEnabled = false
                }
            })
        
        
        _ = VerificationCodeTextField.rx.text.orEmpty.map { (text) -> Bool in
            text.count >= 4
        }.share(replay: 1)
            .subscribe(onNext: { (valid) in
                
                if valid{
                    self.VerificationCodeTextField.text = String(self.VerificationCodeTextField!.text![..<self.VerificationCodeTextField.text!.index(self.VerificationCodeTextField!.text!.startIndex, offsetBy:4)])
                }
                if PhoneNumberIsValidated(vStr: self.phoneNumberTextField.text ?? "") && self.VerificationCodeTextField.text?.count == 4{
                    self.LoginBtn.backgroundColor = UIColor.MainColor
                    self.LoginBtn.isEnabled = true
                    IQKeyboardManager.shared.resignFirstResponder()
                 }else{
                    self.LoginBtn.backgroundColor = UIColor.EnabledColor
                    self.LoginBtn.isEnabled = false
                 }
            })
        
        
        logImageView.image = SVGKImage.init(named: "LOGO").uiImage
        LoginBtn.setImage(SVGKImage.init(named: "xiayibu.svg").uiImage, for: .normal)
    
        
        
    }
    
    @IBAction func backdismisClick(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    func verificationCodeBtnisEnabled(text : String) {
        
        guard PhoneNumberIsValidated(vStr: text ) == true else {

        self.verificationCodeBtn.layer.borderColor = UIColor.EnabledColor.cgColor
        self.verificationCodeBtn.setTitleColor(UIColor.EnabledColor, for: .normal)
        self.verificationCodeBtn.isEnabled = false
                   return
               }
        self.verificationCodeBtn.layer.borderColor = UIColor.MainColor.cgColor
        self.verificationCodeBtn.setTitleColor(UIColor.MainColor, for: .normal)
        self.verificationCodeBtn.isEnabled = true
        
    }

    @IBAction func loginBtnClick(_ sender: Any) {
        
        ApiLoadingProvider.request(DoosApi.login(state: "1", mobile: phoneNumberTextField.text!, password: "", code: VerificationCodeTextField.text!), model: loginModel.self) { (loginData) in
            print(loginData?.token! as Any)
            print(loginData?.member! as Any)
            UserDefaults.standard.setToken(value: loginData?.token ?? "")
            
            UIApplication.shared.keyWindow?.rootViewController = UTabBarController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: false)
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: false)
       }
    
    @IBAction func codeClick(_ sender: AnimatableButton) {
        
        ApiLoadingProvider.request(DoosApi.getSendSms(type: "0", mobile: phoneNumberTextField.text!)) { (sendSms) in }
        isCounting = true
    }
    
    @objc func updateTime(_ timer: Timer) {
           remainingSeconds -= 1
       }
    
}




