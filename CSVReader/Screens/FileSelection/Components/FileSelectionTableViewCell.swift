//
//  FileSelectionTableViewCell.swift
//  CSVReader
//
//  Created by Andrés Pesate on 12/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit

final class FileSelectionTableViewCell: UITableViewCell {

	let fileNameLabel = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

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
		contentView.addSubview(fileNameLabel)
	}

	private func setupConstraints() {
		fileNameLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fileNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: FileSelectionDesignGuidelines.Cell.margin.top),
			fileNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: FileSelectionDesignGuidelines.Cell.margin.left),
			contentView.trailingAnchor.constraint(equalTo: fileNameLabel.trailingAnchor, constant: FileSelectionDesignGuidelines.Cell.margin.right),
			contentView.bottomAnchor.constraint(equalTo: fileNameLabel.bottomAnchor, constant: FileSelectionDesignGuidelines.Cell.margin.bottom)
		])
	}

}
