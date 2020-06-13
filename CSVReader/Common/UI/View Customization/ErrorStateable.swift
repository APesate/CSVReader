//
//  ErrorStateable.swift
//  CSVReader
//
//  Created by Andrés Pesate on 13/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import CommonUI

protocol ErrorStateable {

	var errorView: ErrorView { get }

	func set(errorModel: ErrorView.Model?)

}

extension ErrorStateable where Self: UIView {

	func set(errorModel: ErrorView.Model?) {
		errorView.removeFromSuperview()

		guard let model = errorModel else {
			return
		}

		errorView.model = model
		addSubview(errorView)

		errorView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			errorView.centerYAnchor.constraint(equalTo: centerYAnchor),
			errorView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
			errorView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
			trailingAnchor.constraint(greaterThanOrEqualTo: errorView.trailingAnchor),
			bottomAnchor.constraint(greaterThanOrEqualTo: errorView.bottomAnchor)
		])
	}

}
