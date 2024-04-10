//
//  RegistrationViewController.swift
//  FireAuthFlow
//
//  Created by Nguyễn Tuấn Dũng on 05/04/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class RegistrationViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Khai báo scrollView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Create New Your Account"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noProfile"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let chooseProfileImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addProfileImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapChooseProfileImageButton), for: .touchUpInside)
        return button
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
    
    let confirmTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
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
        eyeButton.addTarget(self, action: #selector(toggleConfirmPasswordView), for: .touchUpInside)
        
        // Tạo rightView
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        rightView.addSubview(eyeButton)
        rightView.frame = CGRect(x: textField.right, y: 0, width: 50, height: 40)
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 0x15 / 255.0, green: 0x1D / 255.0, blue: 0x3B / 255.0, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x0B / 255.0, green: 0x0F / 255.0, blue: 0x2F / 255.0, alpha: 1)
        addSubView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackLoginButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        colorPlaceholder()
    }
    
    private func addSubView() {
        view.addSubview(signUpLabel)
        view.addSubview(profileImageView)
        view.addSubview(chooseProfileImageButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmTextField)
        view.addSubview(signUpButton)
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signUpLabel.frame = CGRect(x: 80, y: 70, width: view.width - 160, height: 70)
        profileImageView.frame = CGRect(x: (view.width - 100) / 2, y: signUpLabel.bottom + 25, width: 100, height: 100)
        chooseProfileImageButton.frame = CGRect(x: (view.width - 30) / 2, y: profileImageView.bottom - 15, width: 30, height: 30)
        emailTextField.frame = CGRect(x: 25, y: chooseProfileImageButton.bottom + 20, width: view.width - 50, height: 60)
        passwordTextField.frame = CGRect(x: 25, y: emailTextField.bottom + 15, width: view.width - 50, height: 60)
        confirmTextField.frame = CGRect(x: 25, y: passwordTextField.bottom + 15, width: view.width - 50, height: 60)
        signUpButton.frame = CGRect(x: 60, y: confirmTextField.bottom + 30, width: view.width - 120, height: 60)
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        sender.isSelected.toggle() // Đảo trạng thái của button
        passwordTextField.isSecureTextEntry.toggle() // Đảo trạng thái hiển thị mật khẩu
    }
    
    @objc func toggleConfirmPasswordView(_ sender: UIButton) {
        sender.isSelected.toggle() // Đảo trạng thái của button
        confirmTextField.isSecureTextEntry.toggle() // Đảo trạng thái hiển thị mật khẩu
    }
    
    func colorPlaceholder() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        confirmTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            textField.layer.borderColor = UIColor.blue.cgColor
        } else if textField == passwordTextField {
            textField.layer.borderColor = UIColor.blue.cgColor
        } else {
            textField.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        } else if textField == passwordTextField {
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        } else {
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        }
    }
    
    @objc func didTapBackLoginButton() {
        let loginVc = LoginViewController()
        let naVC = UINavigationController(rootViewController: loginVc)
        naVC.modalPresentationStyle = .fullScreen
        present(naVC, animated: true)
    }
    
    @objc func didTapSignUpButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0x44 / 255.0, green: 0x9E / 255.0, blue: 0xFF / 255.0, alpha: 1)
        if emailTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true || confirmTextField.text?.isEmpty ?? true {
            let ac = UIAlertController(title: "Thông báo", message: "Thông tin không được để trống. Vui lòng kiểm tra lại.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(ac, animated: true)
        } else if passwordTextField.text != confirmTextField.text {
            let ac = UIAlertController(title: "Thông báo", message: "Mật khẩu xác nhận không chính xác.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(ac, animated: true)
        } else {
            guard let email = emailTextField.text, !email.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty else {
                return
            }
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let user = authResult?.user {
                    // tách tên từ email
                    let nameComponents = email.components(separatedBy: "@")
                    let name = nameComponents.first ?? ""
                    
                    // Tạo một instance mới của model User
                    let newUser = User(uid: user.uid, name: name, avatar: "", email: email, password: password)
                    // Lưu dữ liệu vào bảng `Users` với key là uid của người dùng
                    Database.database().reference().child("Users").child(user.uid).setValue(newUser.toDictionary()) { error, _ in
                       if let error = error {
                            // Xử lý lỗi nếu có
                            print(error.localizedDescription)
                       } else {
                        // Thông báo hoặc xử lý sau khi lưu dữ liệu thành công
                           let ac = UIAlertController(title: "Thành công", message: "Tài khoản đã được tạo thành công.", preferredStyle: .alert)
                           ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                           self.present(ac, animated: true)
                           // Thêm bất kỳ xử lý nào sau khi tạo tài khoản thành công ở đây.
                           // Ví dụ: Chuyển đến màn hình chính hoặc cập nhật giao diện người dùng.
                           self.emailTextField.text = ""
                           self.passwordTextField.text = ""
                           self.confirmTextField.text = ""
                       }
                    }
                }
            }
        }
    }

    // Phần chọn avatar đang được hoàn thiện (TEST)
    @objc func didTapChooseProfileImageButton(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true // Cho phép người dùng chỉnh sửa ảnh

        // Hiển thị image picker
        present(imagePickerController, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate Methods

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Lấy ảnh đã chỉnh sửa từ picker
        if let editedImage = info[.editedImage] as? UIImage {
            // Cập nhật ảnh đại diện với ảnh mới
            profileImageView.image = editedImage

            // Nếu bạn muốn lưu ảnh vào Firebase Storage hoặc cập nhật thông tin người dùng, bạn có thể làm điều đó ở đây
            // uploadProfileImage(editedImage)
        }

        // Đóng image picker
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Người dùng hủy bỏ, đóng image picker
        picker.dismiss(animated: true, completion: nil)
    }

    
}
