//
//  ContentDisplayCollectionViewCell.swift
//  CSVReader
//
//  Created by Andrés Pesate on 13/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit

final class ContentDisplayCollectionViewCell: UICollectionViewCell {

	let contentLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)

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
		contentView.backgroundColor = .secondarySystemGroupedBackground

		contentLabel.textColor = .label
		contentLabel.numberOfLines = 0
		contentLabel.minimumScaleFactor = 0.6
		contentLabel.adjustsFontSizeToFitWidth = true

		contentView.addSubview(contentLabel)
	}

	private func setupConstraints() {
		contentLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ContentDisplayDesignGuidelines.Cell.margin.top),
			contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ContentDisplayDesignGuidelines.Cell.margin.left),
			contentView.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor, constant: ContentDisplayDesignGuidelines.Cell.margin.right),
			contentView.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: ContentDisplayDesignGuidelines.Cell.margin.bottom)
		])
	}

}
