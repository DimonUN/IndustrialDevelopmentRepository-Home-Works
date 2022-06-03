import UIKit

final class LogInViewController: UIViewController {
    
    @objc func tapGesture(_ gesture: UITapGestureRecognizer) {
        print("Did catch action")
    }

    //MARK: -Setting properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()


    //    MARK: - Home Work Start
    private var generatedPassword: String?
    private var pickupedPassword: String?
    private lazy var globalQueue = DispatchQueue.global()

    private lazy var pickupButton: UIButton = {
        let pickupButton = UIButton(type: .system)
        pickupButton.toAutoLayout()
        pickupButton.setTitle("Подобрать пароль", for: .normal)
        pickupButton.setTitleColor(.orange, for: .normal)
        pickupButton.backgroundColor = .white
        pickupButton.layer.borderColor = UIColor.orange.cgColor
        pickupButton.layer.borderWidth = 1.0
        pickupButton.layer.cornerRadius = 10.0
        pickupButton.clipsToBounds = true
        pickupButton.addTarget(
            self,
            action: #selector(getPassword(sender:)),
            for: .touchUpInside
        )

        return pickupButton
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .black
        activityIndicator.toAutoLayout()
        return activityIndicator
    }()

    @objc private func getPassword(sender: UIButton) {
        self.activityIndicator.startAnimating()
        doWorkInGroup()
    }

    private func doWorkInGroup() {
        let group = DispatchGroup()

//        Группа через WorkItem
//        group.enter()
//        let item = DispatchWorkItem(qos: .default, flags: .enforceQoS) {
//            self.generatePassword()
//            print("Password is \(self.generatedPassword ?? "not value")")
//            self.pickupPassword()
//            group.leave()
//        }
//        group.notify(queue: .main) {
//            self.passwordTextField.text = self.pickupedPassword
//            self.passwordTextField.isSecureTextEntry = false
//            self.activityIndicator.stopAnimating()
//        }
//        globalQueue.async(execute: item)

//       Группа через Block кода
        group.enter()
        func work() {
            self.generatePassword()
            print("Password is \(self.generatedPassword ?? "not value")")
            self.pickupPassword()
            group.leave()
        }
        group.notify(queue: .main) {
            self.passwordTextField.text = self.pickupedPassword
            self.passwordTextField.isSecureTextEntry = false
            self.activityIndicator.stopAnimating()
        }
        globalQueue.async {
            work()
        }
    }

    private func generatePassword() {
        let availableCharactersArray: [String] = String().printable.map { String($0) }
        let maxPasswordSize = 3
        func generateRandomString() -> Character {
            let randomInt = Int.random(in: 0..<availableCharactersArray.count)
            return Character(availableCharactersArray[randomInt])
        }
        var passwordArray: [Character] = []
        while passwordArray.count < maxPasswordSize {
            passwordArray.append(generateRandomString())
        }
        generatedPassword = String(passwordArray)
    }

    private func pickupPassword() {
        let bruteForce = BruteForceClass()
        let pickupedPassword = bruteForce.bruteForce(
            passwordToUnlock: generatedPassword ?? ""
        )

        self.pickupedPassword = pickupedPassword
    }

    //    MARK: - Home Work End

    private lazy var logoContentView: UIView = {
        let logoContentView = UIView()
        logoContentView.toAutoLayout()
        return logoContentView
    }()

    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        logoImageView.layer.contents = UIImage(named: "logo")?.cgImage
        logoImageView.layer.contentsGravity = .resizeAspectFill
        logoImageView.layer.masksToBounds = true
        logoImageView.toAutoLayout()
        return logoImageView
    }()

    private lazy var textFieldsContentView: UIView = {
        let textFieldsContentView = UIView()
        textFieldsContentView.toAutoLayout()
        textFieldsContentView.layer.borderColor = UIColor.lightGray.cgColor
        textFieldsContentView.layer.borderWidth = 0.5
        textFieldsContentView.layer.cornerRadius = 10.0
        textFieldsContentView.layer.masksToBounds = true
        textFieldsContentView.backgroundColor = .systemGray6
        return textFieldsContentView
    }()

    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.toAutoLayout()

        loginTextField.placeholder = "Email or phone"
        loginTextField.font = UIFont.systemFont(ofSize: 16.0)
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.returnKeyType = UIReturnKeyType.done
       
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        loginTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.layer.borderWidth = 0.5
        
        loginTextField.backgroundColor = .systemGray6
        loginTextField.textColor = .black
        loginTextField.tintColor = UIColor(named: "ColorSet")
        loginTextField.autocapitalizationType = .none
        loginTextField.delegate = self
        return loginTextField
    }()

    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.toAutoLayout()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 16.0)
        
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textColor = .black
        passwordTextField.tintColor = UIColor(named: "ColorSet")
        passwordTextField.autocapitalizationType = .none
        passwordTextField.delegate = self
        return passwordTextField
    }()

    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.toAutoLayout()
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.layer.cornerRadius = 10.0
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(holdDown), for: .touchDown)
        return loginButton
    }()

    private var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "blue_pixel-1")
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()

    //MARK: -Setting methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(tapGesture))
        
        logoContentView.addGestureRecognizer(recognizer)
        view.backgroundColor = .red
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        logoContentView.addSubview(logoImageView)
        contentView.addSubviews(logoContentView, textFieldsContentView, loginButton, pickupButton, activityIndicator)
        textFieldsContentView.addSubviews(loginTextField, passwordTextField)
        loginButton.addSubview(imageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoContentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            logoContentView.heightAnchor.constraint(equalToConstant: 100.0),
            logoContentView.widthAnchor.constraint(equalToConstant: 100.0),

            textFieldsContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            textFieldsContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            textFieldsContentView.topAnchor.constraint(equalTo: logoContentView.bottomAnchor, constant: 120.0),
            textFieldsContentView.heightAnchor.constraint(equalToConstant: 100.0),

            loginTextField.leadingAnchor.constraint(equalTo: textFieldsContentView.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: textFieldsContentView.trailingAnchor),
            loginTextField.topAnchor.constraint(equalTo: textFieldsContentView.topAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.leadingAnchor.constraint(equalTo: textFieldsContentView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: textFieldsContentView.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: textFieldsContentView.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),


            activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10.0),

            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            loginButton.topAnchor.constraint(equalTo: textFieldsContentView.bottomAnchor, constant: 16.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200.0),

            pickupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 150),
            pickupButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pickupButton.widthAnchor.constraint(equalToConstant: 150.0),
            pickupButton.heightAnchor.constraint(equalToConstant: 50.0),

            imageView.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: loginButton.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.kbdShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.kbdHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(_ notification: NSNotification) {
        if let kbdSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: kbdSize.height,
                right: 0
            )
        }
    }

    @objc private func kbdHide(_ notification: NSNotification) {
        scrollView.contentOffset = CGPoint.zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    @objc func holdRelease(sender: UIButton) {
        imageView.alpha = 1.0
    }

    @objc func holdDown(sender: UIButton) {
        guard loginButton.isSelected || loginButton.isHighlighted else { return }
        imageView.alpha = 0.8

        guard passwordTextField.text?.isEmpty == false else { return }
        if passwordTextField.text == generatedPassword {
            loginTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
            pickupedPassword = nil
            passwordTextField.text = nil
            loginTextField.text = nil
            passwordTextField.isSecureTextEntry = true
        } else {
            let alert = UIAlertController(
                title: "Внимание!",
                message: "Введите корректный пароль!",
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(
                title: "Ok",
                style: .default,
                handler: nil
            )

            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
