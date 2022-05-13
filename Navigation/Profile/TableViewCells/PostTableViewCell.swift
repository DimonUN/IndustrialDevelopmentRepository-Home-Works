import UIKit

final class PostTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.toAutoLayout()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.toAutoLayout()
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .black
        return postImageView
        
    }()
    
    private lazy var postTextLabel: UILabel = {
        let postTextLabel = UILabel()
        postTextLabel.toAutoLayout()
        postTextLabel.font = .systemFont(ofSize: 14.0)
        postTextLabel.textColor = .systemGray
        postTextLabel.numberOfLines = 0
        return postTextLabel
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = .systemFont(ofSize: 16.0)
        likesLabel.textColor = .black
        likesLabel.toAutoLayout()
        return likesLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewLabel = UILabel()
        viewLabel.font = .systemFont(ofSize: 16.0)
        viewLabel.textColor = .black
        viewLabel.toAutoLayout()
        return viewLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubviews(
            titleLabel,
            postImageView,
            postTextLabel,
            likesLabel,
            viewsLabel
        )
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 16.0
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: postTextLabel.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: postTextLabel.trailingAnchor
            ),
            postImageView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 16.0
            ),
            postImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor
            ),
            postImageView.heightAnchor.constraint(
                equalTo: postImageView.widthAnchor
            ),
            postTextLabel.topAnchor.constraint(
                equalTo: postImageView.bottomAnchor, constant: 16.0
            ),
            postTextLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16.0
            ),
            postTextLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16.0
            ),
            likesLabel.topAnchor.constraint(
                equalTo: postTextLabel.bottomAnchor, constant: 16.0
            ),
            likesLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -16.0
            ),
            likesLabel.leadingAnchor.constraint(
                equalTo: postTextLabel.leadingAnchor
            ),
            viewsLabel.topAnchor.constraint(
                equalTo: postTextLabel.bottomAnchor, constant: 16.0
            ),
            viewsLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -16.0
            ),
            viewsLabel.trailingAnchor.constraint(
                equalTo: postTextLabel.trailingAnchor
            )
        ])
    }
    
    public func update(
        title: String,
        image: String,
        description: String,
        likes: Int,
        views: Int
    ) {
        postImageView.image = UIImage(named: image)
        postTextLabel.text = description
        likesLabel.text = "Likes: \(likes)"
        viewsLabel.text = "Views: \(views)"
        titleLabel.text = title
    }
}
