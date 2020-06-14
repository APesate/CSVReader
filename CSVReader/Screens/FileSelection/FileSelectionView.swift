//
//  FileSelectionView.swift
//  CSVReader
//
//  Created by Andrés Pesate on 12/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import CommonUI

final class FileSelectionView: UIView, ErrorStateable {

	let tableView = UITableView(frame: .zero, style: .grouped)
	lazy var errorView = ErrorView()

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

		tableView.backgroundColor = .systemGroupedBackground
		addSubview(tableView)
	}

	private func setupConstraints() {
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
			bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
		])
	}

}
