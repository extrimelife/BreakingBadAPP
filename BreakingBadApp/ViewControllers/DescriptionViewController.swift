//
//  DescriptionViewController.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 23.11.2022.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let imageLabel: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 118
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var birthdayLabel: UILabel = {
        setupLabels()
    }()
    
    private lazy var statusLabel: UILabel = {
        setupLabels()
    }()
    
    private lazy var occupationLabel: UILabel = {
        setupLabels()
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return name
    }()
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        title = nameLabel.text
    }
    
    //MARK: - Public methods
    
    func configure(from character: Character) {
        nameLabel.text = "\u{1F464}" + "\(character.name)"
        occupationLabel.text = "\u{231B}" + "\(character.occupation[0])"
        statusLabel.text =  "\u{1F3C6}"   +   "\(character.status)"
        birthdayLabel.text = "\u{1F382}" + "\(character.birthday)"
        NetworkManager.share.fetchImage(from: character.img) {[unowned self] result in
            switch result {
            case .success(let image):
                imageLabel.image = UIImage(data: image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
//MARK: Private methods
    
    private func setupLabels() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        [imageLabel, birthdayLabel, statusLabel, occupationLabel, nameLabel] .forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLabel.heightAnchor.constraint(equalToConstant: 270),
            imageLabel.widthAnchor.constraint(equalToConstant: 240),
            
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
