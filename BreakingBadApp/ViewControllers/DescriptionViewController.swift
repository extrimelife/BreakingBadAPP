//
//  DescriptionViewController.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 23.11.2022.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var imageUrl: URL? {
        didSet {
            imageLabel.image = nil
        }
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    private let imageLabel: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 100
        image.clipsToBounds = true
        image.sizeToFit()
        return image
    }()
    
    private lazy var birthdayLabel: UILabel = {
        setupLabel()
    }()
    
    private lazy var statusLabel: UILabel = {
        setupLabel()
    }()
    
    private lazy var occupationLabel: UILabel = {
        setupLabel()
    }()
    
    private lazy var nameLabel: UILabel = {
        setupLabel()
    }()
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
       
    }
    
    //MARK: - Public methods
    
    func configure(from character: Character) {
        nameLabel.text = "\u{1F464}" + "\(character.name)"
        occupationLabel.text = "\u{231B}" + "\(character.occupation[0])"
        statusLabel.text =  "\u{1F3C6}"   +   "\(character.status)"
        birthdayLabel.text = "\u{1F382}" + "\(character.birthday)"
        title = character.name
        imageUrl = URL(string: character.img)
        guard let imageUrl = imageUrl else { return }
        NetworkManager.share.fetchImage(from: imageUrl) {[unowned self] result in
            if imageUrl == self.imageUrl {
                switch result {
                case .success(let image):
                    imageLabel.image = UIImage(data: image)
                    activityIndicator.stopAnimating()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
//MARK: Private methods
    
    private func setupLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        [imageLabel, activityIndicator, birthdayLabel, statusLabel, occupationLabel, nameLabel] .forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLabel.heightAnchor.constraint(equalToConstant: 200),
            imageLabel.widthAnchor.constraint(equalToConstant: 200),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageLabel.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageLabel.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            
            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            birthdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            
            statusLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            
            occupationLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            occupationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100)
        ])
    }
}
