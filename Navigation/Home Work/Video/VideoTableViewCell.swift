//
//  VideoTableViewCell.swift
//  AVFoundation_Audio
//
//  Created by Дмитрий Никоноров on 17.06.2022.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func update(name: String) {
        nameLabel.text = name
    }

}
