import UIKit

final class ProfileHeaderView: UIView {

    //MARK: -Private properties
    private lazy var statusText: String = ""

    var avatarImageViewLeadingAnchor: NSLayoutConstraint?
    var avatarImageViewTopAnchor: NSLayoutConstraint?
    var avatarImageViewWidthAnchor: NSLayoutConstraint?
    var avatarImageViewHeightAnchor: NSLayoutConstraint?

    var avatarContentView: UIView = {
        let avatarContentView = UIView()
        avatarContentView.toAutoLayout()
        avatarContentView.alpha = 0
        avatarContentView.backgroundColor = .black
        return avatarContentView
    }()

     lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView(image: UIImage(named: "cat"))
        avatarImageView.layer.cornerRadius = 70
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.contentsGravity = .resizeAspectFill
        avatarImageView.layer.masksToBounds = true
        avatarImageView.toAutoLayout()
        return avatarImageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Hipster cat"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black
        fullNameLabel.toAutoLayout()
        return fullNameLabel
    }()

    private lazy var statusButton: RegularButton = {
        let statusButton = RegularButton(setTitle: "Show status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 12.0
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4.0
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.clipsToBounds = true
        statusButton.touchUpInside = {
            self.buttonRealesed(sender: statusButton)
        }
        statusButton.touchDown = {
            self.buttonPressed(sender: statusButton)
        }
        return statusButton
    }()

    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "blue_pixel-1")
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    
    var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.toAutoLayout()
        statusTextField.backgroundColor = .white
        statusTextField.font = UIFont.systemFont(ofSize: 15)
        statusTextField.placeholder = "Set your status"

        statusTextField.keyboardType = UIKeyboardType.default
        statusTextField.returnKeyType = UIReturnKeyType.done
        statusTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        statusTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        statusTextField.textColor = .black

        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.addTarget(
            self,
            action: #selector(statusTextChanged),
            for: .editingChanged
        )
        return statusTextField
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something"
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.toAutoLayout()
        return statusLabel
    }()

    //MARK: -Methods
    @objc private func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else {return}
        statusText = text
    }
    
    @objc private func buttonPressed(sender: UIButton) {
        statusLabel.text = statusText
        statusButton.alpha = 0.8
    }

    @objc private func buttonRealesed(sender: UIButton) {
        statusButton.alpha = 1.0
    }
    
    private func setupUI() {
        addSubviews(fullNameLabel, statusButton, statusLabel, statusTextField, avatarContentView, avatarImageView)
        statusButton.addSubview(imageView)
        avatarImageView.isUserInteractionEnabled = true
        
        avatarImageViewLeadingAnchor = avatarImageView.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        avatarImageViewLeadingAnchor?.isActive = true
        
        avatarImageViewTopAnchor = avatarImageView.topAnchor.constraint(
                    equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        avatarImageViewTopAnchor?.isActive = true
        
        avatarImageViewWidthAnchor = avatarImageView.widthAnchor.constraint(
                    equalToConstant: 140)
        avatarImageViewWidthAnchor?.isActive = true
        
        avatarImageViewHeightAnchor = avatarImageView.heightAnchor.constraint(
                    equalToConstant: 140)
        avatarImageViewHeightAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            statusButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16
            ),
            safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: statusButton.trailingAnchor, constant: 16
            ),
            statusButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10
            ),
            statusButton.heightAnchor.constraint(
                equalToConstant: 50
            ),
            fullNameLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 186
            ),
            fullNameLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 27
            ),
            statusLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 186
            ),
            statusLabel.topAnchor.constraint(
                equalTo: fullNameLabel.bottomAnchor, constant: 30
            ),
            statusLabel.heightAnchor.constraint(equalToConstant: 15
            ),
            statusTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 186
            ),
            statusTextField.topAnchor.constraint(
                equalTo: statusLabel.bottomAnchor, constant: 10
            ),
            statusTextField.heightAnchor.constraint(
                equalToConstant: 40
            ),
            self.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: statusTextField.trailingAnchor, constant: 16
            ),
            imageView.leadingAnchor.constraint(
                equalTo: statusButton.leadingAnchor
            ),
            imageView.trailingAnchor.constraint(
                equalTo: statusButton.trailingAnchor
            ),
            imageView.topAnchor.constraint(
                equalTo: statusButton.topAnchor
            ),
            imageView.bottomAnchor.constraint(
                equalTo: statusButton.bottomAnchor
            )
        ])
    }

    //    MARK: -Initiolizer
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
}




