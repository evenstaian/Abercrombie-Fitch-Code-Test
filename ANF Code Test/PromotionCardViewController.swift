//
//  PromotionCardViewController.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import UIKit

class PromotionCardViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let promoMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContrainsts()
    }
}

extension PromotionCardViewController: ViewCode {
    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(topDescriptionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(promoMessageLabel)
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(bottomDescriptionLabel)
    }
    
    func setupContrainsts() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            topDescriptionLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 16),
            topDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: topDescriptionLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            promoMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            promoMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            promoMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            buttonsStackView.topAnchor.constraint(equalTo: promoMessageLabel.bottomAnchor, constant: 16),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            bottomDescriptionLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 16),
            bottomDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bottomDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

extension PromotionCardViewController {
    func configure(with data: Explore) {
        titleLabel.text = data.title
        topDescriptionLabel.text = data.topDescription
        promoMessageLabel.text = data.promoMessage
        bottomDescriptionLabel.text = data.bottomDescription
        
        backgroundImageView.image = UIImage(named: data.backgroundImage)
        
        if let content = data.content {
            content.forEach { item in
                let button = UIButton(type: .system)
                button.titleLabel?.font = .systemFont(ofSize: 15)
                button.setTitle(item.title, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .white
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.cornerRadius = 0
                button.translatesAutoresizingMaskIntoConstraints = false
                
                if let url = URL(string: item.target) {
                    button.tag = buttonsStackView.arrangedSubviews.count
                    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                }
                
                buttonsStackView.addArrangedSubview(button)
                
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: 44),
                    button.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.8)
                ])
            }
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // TODO
    }
}
