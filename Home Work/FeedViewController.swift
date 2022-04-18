import UIKit
import SnapKit

final class FeedViewController: UIViewController {

    //MARK: -Initializer

    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -Private properties

    private lazy var post1: Post = {
        let post1 = Post(
            title: "",
            author: "Ignat",
            description: "About the dangers of malnutrition.",
            image: "post1",
            likes: 15,
            views: 581
        )
        return post1
    }()

    private var model: Model

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

    private lazy var textField: RegularTextField = {
        let textField = RegularTextField()
        textField.placeholder = "Введите пароль"
        textField.font = .systemFont(ofSize: 16.0)
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.tintColor = UIColor(named: "ColorSet")
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 10.0
        textField.layer.masksToBounds = true
        return textField
    }()

    private lazy var mainButton: RegularButton = {
        let mainButton = RegularButton(setTitle: "Проверить пароль", for: .normal)
        mainButton.setTitleColor(.white, for: .normal)
        mainButton.layer.cornerRadius = 10.0
        mainButton.clipsToBounds = true
        mainButton.backgroundColor = .systemBlue
        mainButton.touchUpInside = {
            self.checkTextField(sender: mainButton)
        }
        mainButton.touchDown = {
            self.buttonPressed(sender: mainButton)
        }
        return mainButton
    }()

    private lazy var checkLabel: UILabel = {
        let checkLabel = UILabel()
        checkLabel.backgroundColor = .systemGray6
        checkLabel.text = "Проверка"
        checkLabel.textColor = .black
        checkLabel.layer.cornerRadius = 10.0
        checkLabel.layer.masksToBounds = true
        checkLabel.textAlignment = .center
        return checkLabel
    }()

    //MARK: -Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(gotNotification(notification:)),
            name: .verificationPassword,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.kbdShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.kbdHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .verificationPassword, object: nil)
    }

    @objc func gotNotification(notification: Notification) {
        guard let userInfo = notification.userInfo, let color = userInfo["color"] as? UIColor else { return }
        checkLabel.backgroundColor = color
    }

    @objc private func kbdShow(_ notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? NSValue)?.cgRectValue {
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
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    @objc private func checkTextField(sender: UIButton) {
        model.check(word: textField.getPassword(textField))
        mainButton.alpha = 1.0
    }

    @objc private func buttonPressed(sender: UIButton) {
        mainButton.alpha = 0.8
    }
    
    fileprivate func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.width.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.top.equalToSuperview().offset(250.0)
            make.height.equalTo(50.0)
        }
        mainButton.snp.makeConstraints { make in
            make.leading.equalTo(textField)
            make.trailing.equalTo(textField)
            make.top.equalTo(textField.snp_bottomMargin).offset(20.0)
            make.height.equalTo(50.0)
        }
        checkLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50.0)
            make.width.equalTo(100.0)
            make.top.equalTo(mainButton.snp_bottomMargin).offset(100.0)
            make.bottom.equalToSuperview().offset(-100.0)
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Your feed"
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(textField, mainButton, checkLabel)
    }
}

    //MARK: -Extension
extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
