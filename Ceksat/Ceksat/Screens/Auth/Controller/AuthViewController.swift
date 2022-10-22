//
//  AuthViewController.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 22.10.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var isSignInActive: Bool = true {
        didSet {
            if isSignInActive {
                UIView.animate(withDuration: 0.3) {
                    self.signUpView.alpha = .zero
                } completion: { _ in
                    self.signUpView.isHidden = true
                    self.signInView.isHidden = false
                    UIView.animate(withDuration: 0.3) {
                        self.signInView.alpha = 1
                    }
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.signInView.alpha = .zero
                } completion: { _ in
                    self.signInView.isHidden = true
                    self.signUpView.isHidden = false
                    UIView.animate(withDuration: 0.3) {
                        self.signUpView.alpha = 1
                    }
                }
            }
            
            
        }
    }
    
    private lazy var signInView: SignInView = {
        let view = SignInView()
        view.delegate = self
        return view
    }()
    
    private lazy var signUpView: SignUpView = {
        let view = SignUpView()
        view.isHidden = true
        view.didTapAlreadyHaveAnAccountButton = {
            self.isSignInActive = true
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSignInLayout()
        setupSignUpLayout()
    }
    
    private func setupSignInLayout() {
        view.addSubview(signInView)
        signInView.snp.makeConstraints { make in
            make.height.equalTo(338.0)
            make.leading.equalTo(16.0)
            make.trailing.equalTo(-16.0)
            make.center.equalTo(view.snp.center)
        }
    }
    
    private func setupSignUpLayout() {
        view.addSubview(signUpView)
        signUpView.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.trailing.equalTo(-16.0)
            make.center.equalTo(view.snp.center)
        }
    }
}

extension AuthViewController: SignInViewDelegate {
    func didTapForgotPasswordButton() {
        print("Forgot Password Button Tapped!")
    }
    
    func didTapDoYouHaveAnAccountButton() {
        isSignInActive = false
    }
}
