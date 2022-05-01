import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController {

//  MARK: -Setting properties
    private enum CellReuseIdentifiers: String {
        case header
        case photos
        case posts
    }

    private enum NumbersOfCellsInTableView {
        static let zeroSection = 1
        static let firstSection = 1
    }

    private lazy var processor = ImageProcessor()
    private lazy var processedCGImages: [CGImage?] = []

//  MARK: -Home Work
    #if DEBUG
    private var secondImages = PhotosProvider.get()
    private lazy var secondArrayOfImages: [UIImage] = []

    private func prepareImages() {
        secondImages.forEach({
            secondArrayOfImages.append(UIImage(named: $0) ?? UIImage())
        })
    }
    private func processedImages() {
        self.processor.processImagesOnThread(sourceImages: secondArrayOfImages, filter: ColorFilter.motionBlur(radius: 20.0), qos: .userInteractive) { someImages in
            someImages.forEach({
                self.processedCGImages.append($0)
            })
//Время выполнения метода при:
//  ColorFilter.motionBlur(radius: 20.0),
//  qos: .background
//  1.61 сек

//  при ColorFilter.motionBlur(radius: 20.0),
//  qos: .userInteractive
//  657 мс

//  при ColorFilter.posterize,
//  qos: .userInteractive
//  275 мс
        }
    }
    #else
    private lazy var arrayOfPost: [Post] = PostProvider.get()
    private lazy var originalImages: [UIImage] = []

    private func prepareImages() {
        arrayOfPost.forEach({
            originalImages.append(UIImage(named: $0.image) ?? UIImage())
        })

    }
    private func processedImages() {
        self.processor.processImagesOnThread(sourceImages: originalImages, filter: ColorFilter.motionBlur(radius: 20.0), qos: .background) { someImages in
            someImages.forEach({
                self.processedCGImages.append($0)
            })
//Время выполнения метода при:
//  ColorFilter.motionBlur(radius: 20.0),
//  qos: .background
//  298 мс

//  при ColorFilter.motionBlur(radius: 20.0),
//  qos: .userInteractive
//  21 мс

//  при ColorFilter.posterize,
//  qos: .userInteractive
//  113 мс
        }
    }
    #endif

    private var recognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        return recognizer
    }()
    
    private var animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator()
        return animator
    }()

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

//MARK: -Setting methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupHeaderTableView()
        setupLayout()
        prepareImages()
        processedImages()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    var avatarContentViewLeadingAnchor: NSLayoutConstraint?
    var avatarContentViewTrailingAnchor: NSLayoutConstraint?
    var avatarContentViewTopAnchor: NSLayoutConstraint?
    var avatarContentViewBottomAnchor: NSLayoutConstraint?
    
    var avatarImageViewNewWidthAnchor: NSLayoutConstraint?
    var avatarImageViewNewHeightAnchor: NSLayoutConstraint?
    var avatarImageViewCenterXAnchor: NSLayoutConstraint?
    var avatarImageViewCenterYAnchor: NSLayoutConstraint?
    
    @objc func tapGesture(_ gesture: UITapGestureRecognizer) {
        avatarImageViewNewWidthAnchor = header.avatarImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        avatarImageViewNewHeightAnchor = header.avatarImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        avatarImageViewCenterXAnchor = header.avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        avatarImageViewCenterYAnchor = header.avatarImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
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
                }
        )
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
            }
        )
    }

    private func setupLayout() {
        self.view.addSubview(self.closeLabel)
        avatarContentViewLeadingAnchor = self.header.avatarContentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        avatarContentViewTrailingAnchor = self.header.avatarContentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        avatarContentViewTopAnchor = self.header.avatarContentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        avatarContentViewBottomAnchor = self.header.avatarContentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        avatarContentViewLeadingAnchor?.isActive = true
        avatarContentViewTrailingAnchor?.isActive = true
        avatarContentViewTopAnchor?.isActive = true
        avatarContentViewBottomAnchor?.isActive = true
        
        let closeLabelTrailingAnchor = self.closeLabel.trailingAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0)
        let closeLabelTopAnchor = self.closeLabel.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0)
        
        closeLabelTrailingAnchor.isActive = true
        closeLabelTopAnchor.isActive = true
    }

    
    private func setupHeaderTableView() {
        self.header = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220))
        header.avatarImageView.addGestureRecognizer(recognizer)
        self.tableView.tableHeaderView = header
        self.recognizer.addTarget(self, action: #selector(tapGesture(_:)))
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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


//MARK: -extension UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var n = 0
        switch section {
        case 0:
            n = NumbersOfCellsInTableView.zeroSection
        case 1:
            n = NumbersOfCellsInTableView.firstSection
        default:
            #if DEBUG
            n = secondImages.count
            #else
            n = originalImages.count
            #endif
        }
        return n
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.header.rawValue, for: indexPath) as! FirstSectionOfTableView
            cell.selectionStyle = .none
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.photos.rawValue, for: indexPath) as! PhotosTableViewCell
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.posts.rawValue, for: indexPath) as! PostTableViewCell
            #if DEBUG
            guard !processedCGImages.isEmpty else {
                let processedImage = UIImage()
                cell.update(title: "Test", image: processedImage, description: "Test", likes: 0, views: 0)
                return cell
            }
            let processedImage = UIImage(cgImage: processedCGImages[indexPath.row]!)
            cell.update(title: "Test", image: processedImage, description: "Test", likes: 0, views: 0)
            return cell
            #else
            let data = arrayOfPost[indexPath.row]
            guard !processedCGImages.isEmpty else {
                let processedImage = UIImage()
                cell.update(title: data.title, image: processedImage, description: data.description, likes: data.likes, views: data.views)
                return cell
            }
            let processedImage = UIImage(cgImage: processedCGImages[indexPath.row]!)
            cell.update(title: data.title, image: processedImage, description: data.description, likes: data.likes, views: data.views)
            return cell
            #endif
        }
    }
}

//MARK: -extension UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard indexPath.section == 0 else {return}
        let photosVC = PhotosViewController()
        navigationController?.pushViewController(photosVC, animated: true)
    }
}
