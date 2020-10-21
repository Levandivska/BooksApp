//
//  PopularItemCell.swift
//  booksApp
//
//  Created by оля on 05.10.2020.
//  Copyright © 2020 Olya. All rights reserved.
//

import Foundation

import UIKit

class PopularItemCellView: UICollectionViewCell {
    static let reuseIdentifer = "PopularCell"
    
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let imageView = UIImageView()
    let contentContainer = UIView()
    
  var title: String? {
    didSet {
      configure()
    }
  }

  var imageName: String? {
    didSet {
      configure()
    }
  }

  var author: String? {
      didSet {
        configure()
      }
    }
    
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension PopularItemCellView{
  func configure() {
    
    contentContainer.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(imageView)
    contentView.addSubview(contentContainer)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    guard let name = self.imageName else {return }
    let photo = UIImage(named: name)
    
    imageView.image = photo
    imageView.layer.cornerRadius = 4
    imageView.clipsToBounds = true
    contentContainer.addSubview(imageView)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = title
    titleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    titleLabel.adjustsFontForContentSizeCategory = true
    contentContainer.addSubview(titleLabel)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = title
    titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    titleLabel.adjustsFontForContentSizeCategory = true
    contentContainer.addSubview(titleLabel)

    authorLabel.translatesAutoresizingMaskIntoConstraints = false

    if (author != nil) {
        authorLabel.text = "by \(author!)"
    }

    authorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    authorLabel.adjustsFontForContentSizeCategory = true
    authorLabel.textColor = .placeholderText
    contentContainer.addSubview(authorLabel)

    let spacing = CGFloat(10)
    
    NSLayoutConstraint.activate([
      contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
      contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
      titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

      authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
}
