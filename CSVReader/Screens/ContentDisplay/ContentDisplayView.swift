//
//  ContentDisplayView.swift
//  CSVReader
//
//  Created by Andrés Pesate on 10/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import CommonUI

final class ContentDisplayView: UIView, ErrorStateable {

	var collectionViewWidth: CGFloat = UIScreen.main.bounds.width {
		didSet {
			collectionViewWidthConstraint.constant = collectionViewWidth
			layoutIfNeeded()
		}
	}

	private(set) var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.itemSize = ContentDisplayDesignGuidelines.View.itemSize
		layout.minimumInteritemSpacing = ContentDisplayDesignGuidelines.View.minimumInterItemSpacing
		layout.minimumLineSpacing = ContentDisplayDesignGuidelines.View.minimunLineSpacign

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.delaysContentTouches = true
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.backgroundColor = .systemGroupedBackground

		return collectionView
	}()
	let activityIndicator = UIActivityIndicatorView(style: .large)
	let scrollView = UIScrollView(frame: .zero)
	lazy var errorView = ErrorView()
	private var collectionViewWidthConstraint: NSLayoutConstraint!

	init() {
		super.init(frame: .zero)

		setupComponents()
		setupConstraints()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Interface

	// MARK: Private

	private func setupComponents() {
		backgroundColor = .systemGroupedBackground

		activityIndicator.color = .systemOrange
		
		scrollView.isDirectionalLockEnabled = true

		[scrollView, activityIndicator].forEach(addSubview(_:))
		scrollView.addSubview(collectionView)
	}

	private func setupConstraints() {
		[collectionView, scrollView, activityIndicator].forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })

		collectionViewWidthConstraint = collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)

		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),

			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

			collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0),
			collectionViewWidthConstraint
		])
	}

}
