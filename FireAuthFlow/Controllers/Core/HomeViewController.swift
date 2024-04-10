//
//  HomeViewController.swift
//  FireAuthFlow
//
//  Created by Nguyễn Tuấn Dũng on 05/04/2024.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x0B / 255.0, green: 0x0F / 255.0, blue: 0x2F / 255.0, alpha: 1)
        //
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: self, action: #selector(didTapLogOutButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    
    // Hàm đăng xuất tài khoản
    @objc func didTapLogOutButton() {
        do {
            try Auth.auth().signOut()
            // Chuyển đến màn hình đăng nhập hoặc welcome screen sau khi đăng xuất
            let loginVC = LoginViewController()
            let naVC = UINavigationController(rootViewController: loginVC)
            naVC.modalPresentationStyle = .fullScreen
            present(naVC, animated: true)
        } catch let signOutError as NSError {
            print("Đăng xuất thất bại: \(signOutError)")
        }
    }
}
