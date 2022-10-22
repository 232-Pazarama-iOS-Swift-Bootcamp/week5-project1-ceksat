//
//  SignInView.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 22.10.2022.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func didTapForgotPasswordButton()
    func didTapDoYouHaveAnAccountButton()
}

final class SignInView: CSView {
    
    weak var delegate: SignInViewDelegate?
    
    @IBOutlet weak var emailTextView: CSTextView!
    @IBOutlet weak var passwordTextView: CSTextView!
    
    @IBAction func didTapForgotPasswordButton(_ sender: UIButton) {
        delegate?.didTapForgotPasswordButton()
    }
    
    @IBAction func didTapDoYouHaveAnAccountButton(_ sender: UIButton) {
        delegate?.didTapDoYouHaveAnAccountButton()
    }
}
