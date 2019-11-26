//
//  CadastroViewController.swift
//  ShowDoMilhao
//
//  Created by akiracaio on 07/11/19.
//  Copyright © 2019 osGods. All rights reserved.
//

import UIKit
import Firebase

protocol CadastroViewControllerDelegate {
    func chamarTelaLoginDoCadastro()
}

class CadastroViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var delegate: CadastroViewControllerDelegate!
    
    //MARK: Criando a TitleLabel
    var titleLabel: UILabel = {
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Cadastro"
        label.font = UIFont.boldSystemFont(ofSize: 37)
        
        return label
    }()
    
    //MARK: Criando a emptyView
    var emptyView: UIView = {
        var view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .blue
        
        return view
    }()
    
    //MARK: Criando a descricaoLabel
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Por favor se cadastre para continuar usando o show do milhao"
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: Criando o emailTextField
    var emailTextField: UITextField = {
        var textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setIcon(#imageLiteral(resourceName: "iconeEmail"))
        textField.tintColor = UIColor.blue
        textField.placeholder = "Email"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    //MARK: Criando a senhaTextField
    var senhaTextField: UITextField = {
        var textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setIcon(#imageLiteral(resourceName: "iconeSenha"))
        textField.tintColor = UIColor.blue
        textField.placeholder = "Senha"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    
    //MARK: Criando o LogarButton
    var acaoDaTelaButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(CadastroViewController.acaoTela), for: .touchDown)
        
        button.backgroundColor = UIColor.blue
        
        button.setTitle("Cadastrar", for: .normal)
        
        button.layer.cornerRadius = 0.5 * button.frame.size.height
        
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(srgbRed: 255, green: 255, blue: 255, alpha: 100)
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        
        return button
    }()
    
    var userName: UITextField = {
        var textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setIcon(#imageLiteral(resourceName: "iconeLogin"))
        textField.tintColor = UIColor.blue
        textField.placeholder = "Nome"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    //MARK: Criando a labelPossuiConta
    var avisaAcaoTela: UILabel = {
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Ja possui uma conta?"
        label.textAlignment = .center
        
        return label
    }()
    
    
    //MARK: Criando o registroButton
    var trocarTelaButton: UIButton = {
        var button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(CadastroViewController.trocarTela), for: .touchDown)
        
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
        self.hideKeyboardWhenTappedAround()
        self.setupLayout()
    }
    
    @objc private func acaoTela(){
        
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.senhaTextField.text!) { authResult, error in
            
            if let error = error {
                self.showToast(error: true, message: error.localizedDescription)
                return
            }
            			
            if let authResult = authResult {

                let dict: [String : Any] = [
                    "email" : self.emailTextField.text!,
                    "pontos" : 0,
                    "username" : self.userName.text ?? "-"
                ]
                
                self.ref.child("users").child(authResult.user.uid).setValue(dict)
                
                Auth.auth().currentUser?.sendEmailVerification(completion: { (erro) in
                    if let erro = error {
                        self.showToast(error: true, message: erro.localizedDescription)
                    }else {
                        
                        self.dismiss(animated: true)
                    }
                })
                
            }
        }
    }
    
    @objc private func trocarTela(){
        self.delegate.chamarTelaLoginDoCadastro()	
    }
    
    private func setupLayout(){
        self.setupLayoutTitleLabel()
        self.setupEmptyView()
        self.setupDescriptionView()
        self.setupEmailTextField()
        self.setupSenhaTextField()
        self.setupUserNameTextField()
        self.setupLogarButton()
        self.setupLabelPossuiConta()
        self.setupRegistroButton()
    }
    
    private func setupUserNameTextField() {
        self.view.addSubview(self.userName)
        
        NSLayoutConstraint.activate([
            self.userName.topAnchor.constraint(equalTo: self.senhaTextField.bottomAnchor, constant: 32),
            self.userName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32),
            self.userName.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32),
            self.userName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLayoutTitleLabel(){
        
        self.view.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            self.titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        ])
    }
    
    private func setupEmptyView() {
        
        self.view.addSubview(self.emptyView)
        
        NSLayoutConstraint.activate([
            self.emptyView.heightAnchor.constraint(equalToConstant: 5),
            self.emptyView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.emptyView.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.emptyView.rightAnchor.constraint(equalTo: self.titleLabel.leftAnchor, constant: 64),
            
        ])
    }
    
    private func setupDescriptionView() {
        self.view.addSubview(self.descriptionLabel)
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.emptyView.bottomAnchor, constant: 32),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.emptyView.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
        ])
    }
    
    private func setupEmailTextField() {
        self.view.addSubview(self.emailTextField)
        
        NSLayoutConstraint.activate([
            self.emailTextField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 32),
            self.emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32),
            self.emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupSenhaTextField() {
        self.view.addSubview(self.senhaTextField)
        
        NSLayoutConstraint.activate([
            self.senhaTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 32),
            self.senhaTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32),
            self.senhaTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32),
            self.senhaTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLogarButton() {
        self.view.addSubview(self.acaoDaTelaButton)
        
        NSLayoutConstraint.activate([
            self.acaoDaTelaButton.topAnchor.constraint(equalTo: self.userName.bottomAnchor, constant: 32),
            self.acaoDaTelaButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.acaoDaTelaButton.widthAnchor.constraint(equalToConstant: 200),
            self.acaoDaTelaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLabelPossuiConta() {
        self.view.addSubview(self.avisaAcaoTela)
        
        NSLayoutConstraint.activate([
            self.avisaAcaoTela.topAnchor.constraint(equalTo: self.acaoDaTelaButton.bottomAnchor, constant: 64),
            self.avisaAcaoTela.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32),
            self.avisaAcaoTela.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32)
        ])
    }
    
    private func setupRegistroButton() {
        self.view.addSubview(self.trocarTelaButton)
        
        NSLayoutConstraint.activate([
            self.trocarTelaButton.topAnchor.constraint(equalTo: self.avisaAcaoTela.bottomAnchor, constant: 16),
            self.trocarTelaButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.trocarTelaButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: -16)
        ])
    }
}
