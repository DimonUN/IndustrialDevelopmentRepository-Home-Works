import UIKit

final class ProfileViewController: UIViewController {

    //MARK: -Properties
    
    private enum CellReuseIdentifiers: String {
        case header
        case photos
        case posts
    }
    
    private var recognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        return recognizer
    }()
    
    private var animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator()
        return animator
    }()
    
    private lazy var arrayOfPost: [Post] = PostProvider.get()

    private enum NumbersOfCellsInTableView {
        static let zeroSection: Int = 1
        static let firstSection: Int = 1
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutoLayout()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var header: ProfileHeaderView = {
        let header = ProfileHeaderView()
        header.alpha = 0
        return header
    }()
    
    private lazy var closeLabel: UIButton = {
        let closeLabel = UIButton()
        closeLabel.toAutoLayout()
        closeLabel.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeLabel.tintColor = .systemBackground
        closeLabel.alpha = 0
        closeLabel.addTarget(self, action: #selector(closeAvatarImage), for: .touchUpInside)
        return closeLabel
    }()

    //MARK: -Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupHeaderTableView()
        setupLayout()
        header.statusTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

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
    }

    @objc private func kbdShow(_ notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? NSValue)?.cgRectValue {
            tableView.contentInset.bottom = kbdSize.height
            tableView.verticalScrollIndicatorInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: kbdSize.height,
                right: 0
            )
        }
    }

    @objc private func kbdHide(_ notofocation: NSNotification) {
        tableView.contentOffset = CGPoint.zero
        tableView.verticalScrollIndicatorInsets = .zero
    }

    var avatarContentViewLeadingAnchor: NSLayoutConstraint?
    var avatarContentViewTrailingAnchor: NSLayoutConstraint?
    var avatarContentViewTopAnchor: NSLayoutConstraint?
    var avatarContentViewBottomAnchor: NSLayoutConstraint?
    
    var avatarImageViewNewWidthAnchor: NSLayoutConstraint?
    var avatarImageViewNewHeightAnchor: NSLayoutConstraint?
    var avatarImageViewCenterXAnchor: NSLayoutConstraint?
    var avatarImageViewCenterYAnchor: NSLayoutConstraint?
    
    @objc private func tapGesture(_ gesture: UITapGestureRecognizer) {
        avatarImageViewNewWidthAnchor = header.avatarImageView.widthAnchor.constraint(
            equalTo: self.view.widthAnchor)

        avatarImageViewNewHeightAnchor = header.avatarImageView.heightAnchor.constraint(
            equalTo: self.view.widthAnchor
        )
        avatarImageViewCenterXAnchor = header.avatarImageView.centerXAnchor.constraint(
            equalTo: self.view.centerXAnchor
        )
        avatarImageViewCenterYAnchor = header.avatarImageView.centerYAnchor.constraint(
            equalTo: self.view.centerYAnchor
        )
        
        self.tableView.isScrollEnabled = false
        self.tableView.isUserInteractionEnabled = false
        
        UIView.animateKeyframes(
                withDuration: 0.8,
                delay: 0,
                options: .beginFromCurrentState,
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.0,
                        relativeDuration: 0.625) {
                            self.header.avatarContentView.alpha = 0.5
                            self.header.avatarImageViewLeadingAnchor?.isActive = false
                            self.header.avatarImageViewTopAnchor?.isActive = false
                            self.header.avatarImageViewWidthAnchor?.isActive = false
                            self.header.avatarImageViewHeightAnchor?.isActive = false
                            self.header.avatarImageView.layer.cornerRadius = 0

                            self.avatarImageViewNewWidthAnchor?.isActive = true
                            self.avatarImageViewNewHeightAnchor?.isActive = true
                            self.avatarImageViewCenterXAnchor?.isActive = true
                            self.avatarImageViewCenterYAnchor?.isActive = true
                            self.view.layoutIfNeeded()
                        }
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.625,
                        relativeDuration: 0.375) {
                            self.closeLabel.alpha = 1
                        }
                },
                completion: { finished in
                })
    }

    @objc func closeAvatarImage() {
        self.tableView.isUserInteractionEnabled = true
        self.tableView.isScrollEnabled = true
        
        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0,
            options: .beginFromCurrentState,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.375) {
                        self.closeLabel.alpha = 0
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.375,
                    relativeDuration: 0.625) {
                        self.header.avatarContentView.alpha = 0
                        self.avatarImageViewNewWidthAnchor?.isActive = false
                        self.avatarImageViewNewHeightAnchor?.isActive = false
                        self.avatarImageViewCenterXAnchor?.isActive = false
                        self.avatarImageViewCenterYAnchor?.isActive = false
                        
                        self.header.avatarImageViewLeadingAnchor?.isActive = true
                        self.header.avatarImageViewTopAnchor?.isActive = true
                        self.header.avatarImageViewWidthAnchor?.isActive = true
                        self.header.avatarImageViewHeightAnchor?.isActive = true
                        self.header.avatarImageView.layer.cornerRadius = 70
                        self.view.layoutIfNeeded()
                    }
            },
            completion: { finished in
            })
    }

    private func setupLayout() {
        self.view.addSubview(self.closeLabel)
        avatarContentViewLeadingAnchor = header.avatarContentView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor
        )
        avatarContentViewTrailingAnchor = header.avatarContentView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor
        )
        avatarContentViewTopAnchor = header.avatarContentView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor
        )
        avatarContentViewBottomAnchor = header.avatarContentView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor
        )
        
        avatarContentViewLeadingAnchor?.isActive = true
        avatarContentViewTrailingAnchor?.isActive = true
        avatarContentViewTopAnchor?.isActive = true
        avatarContentViewBottomAnchor?.isActive = true
        
        let closeLabelTrailingAnchor = closeLabel.trailingAnchor.constraint(
            equalTo:  view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0
        )
        let closeLabelTopAnchor = closeLabel.topAnchor.constraint(
            equalTo:  view.safeAreaLayoutGuide.topAnchor, constant: 10.0
        )
        
        closeLabelTrailingAnchor.isActive = true
        closeLabelTopAnchor.isActive = true
    }

    private func setupHeaderTableView() {
        self.header = ProfileHeaderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: 220
            )
        )
        header.avatarImageView.addGestureRecognizer(recognizer)
        self.tableView.tableHeaderView = header
        self.recognizer.addTarget(self, action: #selector(tapGesture(_:)))
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
        
        tableView.register(
            FirstSectionOfTableView.self,
            forCellReuseIdentifier: CellReuseIdentifiers.header.rawValue
        )
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseIdentifiers.photos.rawValue
        )
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseIdentifiers.posts.rawValue
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 450
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
}

//MARK: -Extension UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var n = 0
        switch section {
        case 0:
            n = NumbersOfCellsInTableView.zeroSection
        case 1:
            n = NumbersOfCellsInTableView.firstSection
        default:
            n = arrayOfPost.count
        }
        return n
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseIdentifiers.header.rawValue,
                for: indexPath
            ) as! FirstSectionOfTableView

            cell.selectionStyle = .none
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseIdentifiers.photos.rawValue,
                for: indexPath
            ) as! PhotosTableViewCell

            return cell

        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseIdentifiers.posts.rawValue,
                for: indexPath
            ) as! PostTableViewCell

            let data = arrayOfPost[indexPath.row]
            cell.update(
                title: data.title,
                image: data.image,
                description: data.description,
                likes: data.likes,
                views: data.views
            )

            return cell
        }
    }
}

//MARK: -Extension UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard indexPath.section == 0 else {return}
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        header.statusTextField.resignFirstResponder()
        return true
    }
}







