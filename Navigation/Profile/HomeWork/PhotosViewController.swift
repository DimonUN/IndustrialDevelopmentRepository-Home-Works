import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
//MARK: -Выполнение ДЗ
    private let facade = ImagePublisherFacade()
    
    private var imageFromPublisher: [UIImage] = []
    
    private enum CollectionReuseIdentifiers: String {
            case photos
        }
    
    private enum Constants {
        static let imageHeight: CGFloat = 50.0
        static let spacing: CGFloat = 8.0
        static let insets: CGFloat = 8.0
    }
    
    private var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero,
            collectionViewLayout: viewLayout)
        collectionView.toAutoLayout()
        
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
//MARK: -Выполнение ДЗ
    override func viewWillDisappear(_ animated: Bool) {
        facade.removeSubscription(for: self)
        facade.rechargeImageLibrary()
    }
    
    
//MARK: -Выполнение ДЗ
    fileprivate func setupFromFacade() {
        let arrayOfImages = PhotosProvider()
        facade.subscribe(self)
        facade.addImagesWithTimer(time: 0.1, repeat: 30, userImages: arrayOfImages.getImages())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollection()
        setupFromFacade()
    }
    
    fileprivate func setupCollection() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CollectionReuseIdentifiers.photos.rawValue)
    }
    
    fileprivate func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Photo Gallery"
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosProvider {
    func getImages() -> [UIImage] {
        let arrayOfString = PhotosProvider.get()
        var arrayOfImages: [UIImage] = []
        for name in arrayOfString {
            arrayOfImages.append(UIImage(named: name) ?? UIImage())
        }
        return arrayOfImages
    }
}


//MARK: -Выполнение ДЗ
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        self.imageFromPublisher = images
        collectionView.reloadData()
    }
}


//MARK: -Выполнение ДЗ
extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageFromPublisher.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionReuseIdentifiers.photos.rawValue, for: indexPath) as! PhotosCollectionViewCell
        
        let data = imageFromPublisher[indexPath.row]
        
        cell.setup(image: data)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        let totalSpacing: CGFloat = 3 * spacing + (itemsInRow - 2) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = itemWidth(for: view.frame.width, spacing: Constants.spacing)
        return CGSize(width: size, height: size)
            
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
            return UIEdgeInsets(
                top: Constants.insets,
                left: Constants.insets,
                bottom: Constants.insets,
                right: Constants.insets
            )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.spacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.insets
    }
}
