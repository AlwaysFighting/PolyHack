import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Variable
    let colorSet = ColorSet()
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        TextFieldUI()
        BtnUI()
        SetDelegate()
        
        // Activity
        updateButtonState()
        keyboardUpDown()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 키보드 notification 삭제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - OBJC
    @objc func keyboardWillshowHandle(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if keyboardSize.height < loginBtn.frame.origin.y {
                let distance = keyboardSize.height - loginBtn.frame.origin.y
                self.view.frame.origin.y = distance + loginBtn.frame.height
            }
        }
        self.view.frame.origin.y = -100
    }

    @objc func keyboardWillHideHandle() {
        self.view.frame.origin.y = 0
    }

    // MARK: - Func
    
    func keyboardUpDown() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshowHandle(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func eyeButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
    
    // Delegate
    func SetDelegate() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // UI
    func TextFieldUI() {
        
        // loginButton
        loginBtn.layer.cornerRadius = 9.0
        loginBtn.setTitle("Login", for: .normal)
        
        // loginTextfield
        loginTextField.layer.cornerRadius = 9.0
        loginTextField.layer.borderColor = colorSet.MainColor.cgColor
        loginTextField.layer.borderWidth = 1.5
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 68, height: 16))
        let imageView = UIImageView(frame: CGRect(x: (paddingView.bounds.width - 16) / 2, y: 0, width: 16, height: 16))
        imageView.image = UIImage(named: "Person")
        paddingView.addSubview(imageView)
        loginTextField.leftView = paddingView
        loginTextField.leftViewMode = .always
        
        
        // passwordTextField
        passwordTextField.layer.cornerRadius = 9.0
        passwordTextField.layer.borderColor = colorSet.MainColor.cgColor
        passwordTextField.layer.borderWidth = 1.5
        
        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 68, height: 16))
        let passwordImageView = UIImageView(frame: CGRect(x: (passwordPaddingView.bounds.width - 16) / 2, y: -4, width: 16, height: 21))
        passwordImageView.image = UIImage(named: "Password")
        passwordPaddingView.addSubview(passwordImageView)
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
    }
    
    // Login Button UI
    func BtnUI() {
        let eyeButton = UIButton(type: .custom)
        
        eyeButton.setImage(UIImage(named: "Eyeslash"), for: .normal)
        eyeButton.setImage(UIImage(named: "Eye"), for: .selected)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        eyeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 18.5)
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped(_:)), for: .touchUpInside)
        
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        
    }
    
    func showErrorLabel() {
        errorLabel.isHidden = false
    }
    
    // MARK: - IBAction
    
    // Login Button
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        
        let username = "echo"
        let password = "chamber"
        
        guard let enteredUsername = loginTextField.text,
              let enteredPassword = passwordTextField.text else {
            return
        }
        
        if enteredUsername != username {
            errorLabel.text = "        아이디가 일치하지 않습니다."
            showErrorLabel()
            return
        } else if  enteredPassword != password {
            errorLabel.text = "        비밀번호가 일치하지 않습니다."
            showErrorLabel()
            return
        } else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            homeViewController.modalPresentationStyle = .fullScreen
            self.present(homeViewController, animated: true, completion: nil)
        }
    }
    
    // 회원가입
    @IBAction func RegisterBtnTapped(_ sender: UIButton) {
        print("회원가입")
    }
    
}

// TextField
extension LoginVC : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButtonState()
    }
    
    func updateButtonState() {
        loginBtn.isEnabled = !loginTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
        
        let backgroundColor: UIColor = loginBtn.isEnabled ? colorSet.ButtonEnabledColor : colorSet.ButtonDisabledColor
        loginBtn.backgroundColor = backgroundColor
    }
}

