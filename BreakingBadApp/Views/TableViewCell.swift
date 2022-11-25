//
//  TableViewCell.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 21.11.2022.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private var imageMain: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let firstLabel: UILabel = {
        let firstImage = UILabel()
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        firstImage.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return firstImage
    }()
    
    private let secondLabel: UILabel = {
        let secondLabel = UILabel()
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        secondLabel.textColor = .systemGray2
        return secondLabel
    }()
    
    //MARK: - Override methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func configure(from character: Character) {
        firstLabel.text = character.name
        secondLabel.text = character.nickname
        NetworkManager.share.fetchImage(from: character.img) { result in
            switch result {
            case .success(let image):
                self.imageMain.image = UIImage(data: image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Private functions
    
    private func setupLayout() {
        [imageMain, firstLabel, secondLabel] .forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            imageMain.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageMain.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageMain.widthAnchor.constraint(equalToConstant: 80),
            imageMain.heightAnchor.constraint(equalToConstant: 80),
            imageMain.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            firstLabel.leadingAnchor.constraint(equalTo: imageMain.trailingAnchor, constant: 16),
            
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5),
            secondLabel.leadingAnchor.constraint(equalTo: imageMain.trailingAnchor, constant: 16)
        ])
    }
}
