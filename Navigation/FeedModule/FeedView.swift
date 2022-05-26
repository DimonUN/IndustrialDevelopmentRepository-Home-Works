//
//  FeedView.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 25.04.2022.
//

import UIKit
import SnapKit

class FeedView: UIView {

    //MARK: -Interface
    var checkTextField: (() -> Void)?

    var onButtonTap: (() -> Void)?

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .systemCyan
        nameLabel.textColor = .white
        nameLabel.layer.cornerRadius = 10.0
        nameLabel.layer.borderWidth = 1.5
        nameLabel.layer.borderColor = UIColor.white.cgColor
        nameLabel.clipsToBounds = true
        return nameLabel
    }()

    //MARK: -Initializer
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(textField, mainButton, checkLabel, nextViewButton, nameLabel)
        toAutoLayout()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -Private properties
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

    private lazy var nextViewButton: UIButton = {
        let nextViewButton = UIButton(type: .system)
        nextViewButton.setTitle("Post view", for: .normal)
        nextViewButton.setTitleColor(.white, for: .normal)
        nextViewButton.backgroundColor = .systemBlue
        nextViewButton.layer.cornerRadius = 10.0
        nextViewButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return nextViewButton
    }()

    //MARK: -Methods
    func updateCheckLabel(color: UIColor) {
        checkLabel.backgroundColor = color
    }

    func scrollViewShowKbd(size: CGFloat, insets: UIEdgeInsets) {
        scrollView.contentInset.bottom = size
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(
            top: insets.top,
            left: insets.left,
            bottom: size,
            right: insets.right
        )
    }

    func scrollViewHideKbd(inset: UIEdgeInsets) {
        scrollView.contentInset = inset
        scrollView.verticalScrollIndicatorInsets = inset
    }

    func getDataFromTextFielf() -> Int {
        let data = textField.getPassword()
        return data
    }

    func addDelegate(delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }

    @objc func buttonTapped(_ sender: UIButton) {
        onButtonTap?()
    }



    //MARK: -Private methods
    @objc private func checkTextField(sender: UIButton) {
        checkTextField?()
        mainButton.alpha = 1.0
    }

    @objc private func buttonPressed(sender: UIButton) {
        mainButton.alpha = 0.8
    }

    private func setupLayout() {
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
        nextViewButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(checkLabel)
            make.top.equalTo(checkLabel.snp_bottomMargin).offset(50.0)
            make.height.equalTo(50.0)
        }

        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20.0)
            make.height.equalTo(50.0)
            make.width.greaterThanOrEqualTo(100.0)
        }
    }
}
