//
//  ViewController.swift
//  StretchingPicture
//
//  Created by Margarita Slesareva on 19.02.2024.
//

import UIKit

private enum Constants {
    static let imageHeight: CGFloat = 270
}

final class ViewController: UIViewController {
    
    private var headerTopConstraint = NSLayoutConstraint()
    private var headerHeightConstraint = NSLayoutConstraint()

    private let imageView = UIImageView()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        addConstraints()
        configureViews()
    }
    
    private func addViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }
    
    private func addConstraints() {
        headerTopConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        headerHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerTopConstraint,
            headerHeightConstraint
        ])
    }
    
    private func configureViews() {
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        scrollView.backgroundColor = .systemBackground
        scrollView.delegate = self
        scrollView.contentSize.height = view.bounds.height * 2
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        headerTopConstraint.isActive = false
        headerHeightConstraint.isActive = false
        
        let newHeight = Constants.imageHeight - scrollView.contentOffset.y
        
        if scrollView.contentOffset.y > 0 {
            headerTopConstraint = imageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: -scrollView.contentOffset.y
            )
        }
        
        headerHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: newHeight)

        NSLayoutConstraint.activate([
            headerHeightConstraint,
            headerTopConstraint
        ])
        
        let topInset = max(newHeight, Constants.imageHeight) - view.safeAreaInsets.top
        scrollView.verticalScrollIndicatorInsets.top = topInset
    }
}
