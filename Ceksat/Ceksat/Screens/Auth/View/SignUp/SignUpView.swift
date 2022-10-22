//
//  SignUpView.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 22.10.2022.
//

import UIKit

final class SignUpView: CSView {
    
    var didTapAlreadyHaveAnAccountButton: (() -> Void)?
    
    @IBOutlet weak var usernameTextView: CSTextView!
    @IBOutlet weak var emailTextView: CSTextView!
    @IBOutlet weak var genderTextView: CSTextView!
    @IBOutlet weak var birthDayTextView: CSTextView!
    @IBOutlet weak var passwordTextView: CSTextView!
    @IBOutlet weak var passwordAgainTextView: CSTextView!
    
    @IBAction func didTapAlreadyHaveAnAccountButton(_ sender: UIButton) {
        didTapAlreadyHaveAnAccountButton?()
    }
}
