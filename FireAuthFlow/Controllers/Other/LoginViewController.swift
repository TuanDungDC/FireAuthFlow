//
//  LoginViewController.swift
//  FireAuthFlow
//
//  Created by Nguyễn Tuấn Dũng on 05/04/2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import FirebaseCore

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LaunchScreenLogo"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let descLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back, Movie Lovers!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.tintColor = .white
        textField.textColor = .white
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.tintColor = .white
        textField.textColor = .white
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        // Tạo button hình con mắt
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal) // Icon mắt mở
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected) // Icon mắt đóng
        eyeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        // Tạo một UIView để chứa eyeButton và đặt lề phải
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        rightView.addSubview(eyeButton)
        rightView.frame = CGRect(x: textField.right, y: 0, width: 50, height: 40)
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()



    let forgotPassButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 0x15 / 255.0, green: 0x1D / 255.0, blue: 0x3B / 255.0, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Create new account?"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    let loginGoogleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginGoogle"), for: .normal)
        button.layer.cornerRadius = 1000
        return button
    }()
    
    let loginFacebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginFacebook"), for: .normal)
        button.layer.cornerRadius = 1000
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x0B / 255.0, green: 0x0F / 255.0, blue: 0x2F / 255.0, alpha: 1)
        addSubView()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        colorPlaceholder()
    }
    
    private func addSubView() {
        view.addSubview(logoImageView)
        view.addSubview(descLoginLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPassButton)
        view.addSubview(loginButton)
        view.addSubview(signUpLabel)
        view.addSubview(signUpButton)
        view.addSubview(loginGoogleButton)
        view.addSubview(loginFacebookButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.frame = CGRect(x: 0, y: 120, width: 144, height: 144)
        descLoginLabel.frame = CGRect(x: 25, y: logoImageView.bottom + 20, width: 200, height: 70)
        emailTextField.frame = CGRect(x: 25, y: descLoginLabel.bottom + 20, width: view.width - 50, height: 60)
        passwordTextField.frame = CGRect(x: 25, y: emailTextField.bottom + 10, width: view.width - 50, height: 60)
        forgotPassButton.frame = CGRect(x: view.width - 135, y: passwordTextField.bottom + 5, width: 110, height: 20)
        loginButton.frame = CGRect(x: 60, y: forgotPassButton.bottom + 20, width: view.width - 120, height: 60)
        signUpLabel.frame = CGRect(x: 80, y: loginButton.bottom + 10, width: 140, height: 20)
        signUpButton.frame = CGRect(x: view.width - 140, y: loginButton.bottom + 10, width: 60, height: 20)
        loginGoogleButton.frame = CGRect(x: (view.width - 168) / 2, y: signUpLabel.bottom + 20, width: 64, height: 64)
        loginFacebookButton.frame = CGRect(x: view.width - (view.width - 168) / 2 - 64, y: signUpLabel.bottom + 20, width: 64, height: 64)
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        sender.isSelected.toggle() // Đảo trạng thái của button
        passwordTextField.isSecureTextEntry.toggle() // Đảo trạng thái hiển thị mật khẩu
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            textField.layer.borderColor = UIColor.blue.cgColor // Thay đổi màu viền khi textField được chọn
            // Di chuyển placeholder lên trên (bạn cần tạo một UILabel để làm placeholder động)
        } else {
            textField.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor // Trả lại màu viền ban đầu khi textField không được chọn
            // Đặt lại vị trí của placeholder nếu cần
        } else {
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        }
    }
    
    func colorPlaceholder() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0x44 / 255.0, green: 0x9E / 255.0, blue: 0xFF / 255.0, alpha: 1)
        if emailTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true {
            let ac = UIAlertController(title: "Thông báo", message: "Thông tin không được để trống. Vui lòng kiểm tra lại.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(ac, animated: true)
        } else {
            guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
                return
            }
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    let ac = UIAlertController(title: "Lỗi", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(ac, animated: true)
                } else if (authResult?.user) != nil {
                    let ac = UIAlertController(title: "Thông báo", message: "Đăng nhập thành công", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                        let tabBarVC = TabBarViewController()
                        let naVC = UINavigationController(rootViewController: tabBarVC)
                        naVC.modalPresentationStyle = .fullScreen
                        self.present(naVC, animated: true)
                    }))
                    self.present(ac, animated: true)
                    // Thêm bất kỳ xử lý nào sau khi tạo tài khoản thành công ở đây.
                    // Ví dụ: Chuyển đến màn hình chính hoặc cập nhật giao diện người dùng.
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
            }
        }
    }
    
    @objc func didTapSignUpButton() {
        let regisVc = RegistrationViewController()
        let naVC = UINavigationController(rootViewController: regisVc)
        naVC.modalPresentationStyle = .fullScreen
        present(naVC, animated: true)
    }
    
    @objc func didTapLoginGoogle() {
    
    }

    @objc func didTapLoginFacebook() {
        
    }
}

