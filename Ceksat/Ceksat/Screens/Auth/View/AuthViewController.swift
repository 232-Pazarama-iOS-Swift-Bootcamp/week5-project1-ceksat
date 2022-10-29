//
//  AuthViewController.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 22.10.2022.
//

import UIKit

protocol AuthPresenterToViewProtocol: AnyObject {
    
}

final class AuthViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
    }
    
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
        
        view.genderTextView.delegate = self
        view.birthDayTextView.delegate = self
        
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self,
                             action: #selector(didDatePickerValueChanged(_:)),
                             for: .valueChanged)
        return datePicker
    }()
    
    private lazy var genderPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupSignInLayout()
        setupSignUpLayout()
        
        #if targetEnvironment(simulator)
        signInView.emailTextView.text = "mkarakul"
        signInView.passwordTextView.text = "123456"
        #endif
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
    
    @objc private func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        signUpView.birthDayTextView.text = formatter.string(from: sender.date)
    }
    
    
    @IBAction func didContinueButtonTapped(_ sender: UIButton) {
        if isSignInActive {
            guard let username = signInView.emailTextView.text,
                  let password = signInView.passwordTextView.text
            else {
                return
            }
            viewModel.signInWithUserName(username,
                                         andPassword: password)
        } else {
            guard let username = signUpView.usernameTextView.text,
                  let email = signUpView.emailTextView.text,
                  let gender = signUpView.genderTextView.text,
                  let birthDay = signUpView.birthDayTextView.text,
                  let password = signUpView.passwordTextView.text,
                  let passwordAgain = signUpView.passwordAgainTextView.text
            else {
                return
            }
            
            if password == passwordAgain {
                let user = User()
                user.username = username
                user.email = email
                user.gender = gender
                user.birthDay = birthDay
                user.password = password
                viewModel.signUp(user)
            } else {
                signUpView.passwordAgainTextView.error = "It's not same with password field."
            }
        }
    }
}

// MARK: - SignInViewDelegate
extension AuthViewController: SignInViewDelegate {
    func didTapForgotPasswordButton() {
        print("Forgot Password Button Tapped!")
    }
    
    func didTapDoYouHaveAnAccountButton() {
        isSignInActive = false
    }
}

// MARK: - CSTextViewDelegate
extension AuthViewController: CSTextViewDelegate {
    func textView(_ view: CSTextView, textFieldDidBeginEditing textField: UITextField) {
        
        switch view {
        case signUpView.birthDayTextView:
            textField.inputView = datePicker
        case signUpView.genderTextView:
            textField.inputView = genderPickerView
        default:
            break
        }
    }
}

// MARK: - UIPickerViewDelegate
extension AuthViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        signUpView.genderTextView.text = Gender.allCases[row].rawValue
    }
}

// MARK: - UIPickerViewDataSource
extension AuthViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Gender.allCases[row].rawValue
    }
    
    private func goToMainScreen() {
        navigationController?.pushViewController(MainTabBarController(),
                                                 animated: true)
    }
}

// MARK: - AuthViewModelDelegate
extension AuthViewController: AuthViewModelDelegate {
    func didSignInSusccesful(_ isSuccessful: Bool) {
        if isSuccessful {
            goToMainScreen()
        } else {
            print("Username or password is not valid.")
        }
    }
    
    func didUserCreated() {
        goToMainScreen()
    }
    
    func didErrorOccurred(_ error: Error) {
        print(error)
    }
}
