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
    
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        addConstraints()
        configureViews()
    }
    
    private func addViews() {
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        imageView.frame = .init(origin: .zero, size: .init(width: view.bounds.width, height: Constants.imageHeight))
    }
    
    private func configureViews() {
        imageView.image = UIImage(named: "image")
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.delegate = self
        scrollView.contentSize.height = view.bounds.height * 1.5
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newHeight = Constants.imageHeight - scrollView.contentOffset.y
        
        imageView.frame.origin.y = min(scrollView.contentOffset.y, 0)
        imageView.frame.size.height = max(newHeight, Constants.imageHeight)
        
        let topInset = max(newHeight, Constants.imageHeight) - view.safeAreaInsets.top
        scrollView.verticalScrollIndicatorInsets.top = topInset
    }
}
