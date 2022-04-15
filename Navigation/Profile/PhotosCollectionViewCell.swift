import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.layer.contentsGravity = .resizeAspectFill
        image.clipsToBounds = true
        
        return image
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor)
        ])
    }
    
    public func setup(image: UIImage) {
        self.image.image = image
    }
}
