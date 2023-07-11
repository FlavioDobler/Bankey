//
//  ViewController.swift
//  Bankey
//
//  Created by Flavio Dobler on 22/04/23.
//

import UIKit

protocol LogoutDelegate : AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate : AnyObject {
    func didLogIn()
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subLabel = UILabel()
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    weak var delegate : LoginViewControllerDelegate?
    
    
    var username : String?  {
        return loginView.userNameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false 
    }


}

extension LoginViewController {
    
    private func style(){
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bankey"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .black
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "Your premium source for all \nthings banking!"
        subLabel.numberOfLines = 0
        subLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        subLabel.textAlignment = .center
        subLabel.textColor = .black
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // spacing between image and text on the button
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        
                
    }
    
    private func layout(){
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //Title
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        //Subtitle
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 4),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        //LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
        ])
        
        //Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //Error Label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
            
        ])
    }
}

// MARK: Actions
extension LoginViewController {
    @objc private func signInTapped(){
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login(){
        guard let username = username, let password = password else {
            assertionFailure("Username / Password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / Password cannot be blank")
            return
        }
        
        if username == "Kevin" && password == "123"{
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogIn()
        } else {
            configureView(withMessage: "Incorrect Username / Password")
        }
    }
    
    
    private func configureView(withMessage message : String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
