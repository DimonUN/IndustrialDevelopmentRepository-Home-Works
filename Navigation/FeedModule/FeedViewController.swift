//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 25.04.2022.
//


import UIKit
import SnapKit

protocol ViewInput: AnyObject {
    func configure(text: String)
}

final class FeedViewController: UIViewController {

    //MARK: -Initializer
    init(output: ViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -Private properties
    private var output: ViewOutput
    private var feedView = FeedView()


    //MARK: -Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

    //MARK: -Private methods
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Your feed"
    }

    private func configureView(labelText: String) {
        view.addSubviews(feedView)
        feedView.addDelegate(delegate: self)
        feedView.nameLabel.text = labelText

        feedView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        feedView.onButtonTap = { [weak self] in
            self?.output.onSelectViewOutput?(.post)
        }

        feedView.checkTextField = { [weak self] in
            self?.output.onSelectOutputData?(self?.feedView.getDataFromTextFielf() ?? 0)
        }
    }

    @objc private func gotNotification(notification: Notification) {
        guard let userInfo = notification.userInfo, let color = userInfo["color"] as? UIColor else { return }
        feedView.updateCheckLabel(color: color)
    }

    @objc private func kbdShow(_ notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? NSValue)?.cgRectValue {
            feedView.scrollViewShowKbd(
                size: kbdSize.height,
                insets: UIEdgeInsets(
                                top: 0,
                                left: 0,
                                bottom: kbdSize.height,
                                right: 0
                )
            )
        }
    }

    @objc private func kbdHide(_ notification: NSNotification) {
        feedView.scrollViewHideKbd(inset: .zero)
    }
}

    //MARK: -Extension
extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension FeedViewController: ViewInput {
    func configure(text: String) {
        configureView(labelText: text)
    }
}
