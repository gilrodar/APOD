//
//  DetailViewController.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .systemBlue
        return activityIndicatorView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let copyrightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(copyrightLabel)
        stackView.addArrangedSubview(explanationLabel)
        return stackView
    }()
    
    var viewModel: DetailViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        navigationItem.title = viewModel.dateString
        
        view = UIView()
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(activityIndicatorView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: Methods
    
    private func bindViewModel() {
        viewModel.photoInfo = { [weak self] photoInfo in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.titleLabel.text = photoInfo.title
                self.imageView.kf.setImage(with: photoInfo.photoURL)
                self.copyrightLabel.isHidden = photoInfo.copyright == nil
                self.copyrightLabel.text = photoInfo.copyright
                self.explanationLabel.text = photoInfo.explanation
            }
        }
        
        viewModel.showLoading = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { self.activityIndicatorView.startAnimating() }
        }
        
        viewModel.hideLoading = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { self.activityIndicatorView.stopAnimating() }
        }
        
        viewModel.showError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let okAction = UIAlertAction(title: "Ok", style: .default)
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
        }
        
        viewModel.getInfo()
    }
    
}
