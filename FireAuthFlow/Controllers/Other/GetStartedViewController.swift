//
//  GetStartedViewController.swift
//  FireAuthFlow
//
//  Created by Nguyễn Tuấn Dũng on 05/04/2024.
//

import UIKit

class GetStartedViewController: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LogoApp"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameAppLabel: UILabel = {
        let label = UILabel()
        label.text = "AD Movies"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let descAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Watch a new movie much easier than any before"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let getSButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = UIColor(red: 0x15 / 255.0, green: 0x1D / 255.0, blue: 0x3B / 255.0, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapGetStartedButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x0B / 255.0, green: 0x0F / 255.0, blue: 0x2F / 255.0, alpha: 1)
        addSubView()
    }
    
    private func addSubView() {
        view.addSubview(logoImageView)
        view.addSubview(nameAppLabel)
        view.addSubview(descAppLabel)
        view.addSubview(getSButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.frame = CGRect(x: view.width/2 - 100, y: 150, width: 200, height: 200)
        nameAppLabel.frame = CGRect(x: 25, y: logoImageView.bottom + 40, width: view.width - 50, height: 30)
        descAppLabel.frame = CGRect(x: 25, y: nameAppLabel.bottom + 10, width: view.width - 50, height: 60)
        getSButton.frame = CGRect(x: 60, y: descAppLabel.bottom + 40, width: view.width - 120, height: 60)
    }
    
    @objc func didTapGetStartedButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0x44 / 255.0, green: 0x9E / 255.0, blue: 0xFF / 255.0, alpha: 1)
        let loginVc = LoginViewController()
        let naVC = UINavigationController(rootViewController: loginVc)
        naVC.modalPresentationStyle = .fullScreen
        present(naVC, animated: true)
        
    }
    
}
