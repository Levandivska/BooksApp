//
//  DiscoverItemCell.swift
//  booksApp
//
//  Created by оля on 05.10.2020.
//  Copyright © 2020 Olya. All rights reserved.
//


import UIKit

class DiscoverItemCellView: UICollectionViewCell {
    
    static let reuseIdentifer = "DiscoverCell"
    let imageView = UIImageView()
    let contentContainer = UIView()
    
    var imageName: String? {
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

extension DiscoverItemCellView{
  func configure() {
    
    contentContainer.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(contentContainer)

    guard let name = self.imageName else {return }
    let photo = UIImage(named: name)
    imageView.image = photo

    imageView.translatesAutoresizingMaskIntoConstraints = false
    contentContainer.addSubview(imageView)

    NSLayoutConstraint.activate([
      contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
      contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
      imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor)
    ])
  }
}


