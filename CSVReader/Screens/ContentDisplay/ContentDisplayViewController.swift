//
//  ContentDisplayViewController.swift
//  CSVReader
//
//  Created by Andrés Pesate on 10/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import Combine
import CommonUI

final class ContentDisplayViewController: UIViewController, ViewProtocol, Titleable {

	var viewModel: ContentDisplayViewModel

	private var myView: ContentDisplayView! { view as? ContentDisplayView }
	private var disposables = Set<AnyCancellable>()

	init(viewModel: ContentDisplayViewModel) {
		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = ContentDisplayView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupComponents()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		bindContent()
		viewModel.loadData()
	}

	// MARK: Private

	// MARK: Observers

	private func bindContent() {
		bindDataSource()
		bindLoadingState()
		bindErrorState()
	}

	private func bindLoadingState() {
		viewModel
			.$isLoading
			.sink(receiveValue: { [weak myView] isLoading in
				isLoading ?
					myView?.activityIndicator.startAnimating() :
					myView?.activityIndicator.stopAnimating()
			})
			.store(in: &disposables)
	}

	private func bindErrorState() {
		viewModel
			.$error
			.sink(receiveValue: { [weak myView] (error) in
				guard let error = error else {
					myView?.set(errorModel: nil)
					return
				}

				switch error {
					case .failedToOpenFile:
						myView?.set(errorModel: ErrorView.Model(icon: UIImage(named: "error_warning"), description: "content_display_failed_to_open_file".localized))

					case .fileNotFound:
						myView?.set(errorModel: ErrorView.Model(icon: UIImage(named: "error_warning"), description: "content_display_file_not_found".localized))
				}
			})
			.store(in: &disposables)
	}

	// MARK: Setup

	private func setupComponents() {
		myView.collectionView.register(ContentDisplayCollectionViewCell.self, forCellWithReuseIdentifier: ContentDisplayCollectionViewCell.className)
		myView.collectionView.dataSource = self
	}

}

// MARK: - CollectionView
extension ContentDisplayViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return viewModel.dataSource.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.dataSource[section].values.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentDisplayCollectionViewCell.className, for: indexPath) as? ContentDisplayCollectionViewCell else {
			assertionFailure("\(String(describing: self)): Is trying to use an unregistered cell type.")
			return UICollectionViewCell()
		}

		let model = viewModel.dataSource[indexPath.section]
		let content = model.values[indexPath.row]
		cell.contentLabel.text = content.isEmpty ? "-" : content

		return cell
	}

	private func bindDataSource() {
		viewModel
			.$dataSource
			.sink { [weak myView] (records) in
				guard let numberOfColumns = records.first?.values.count else {
					return
				}
				let contentSizeWidth = CGFloat(numberOfColumns) * ContentDisplayDesignGuidelines.View.itemSize.width

				myView?.scrollView.contentSize = CGSize(width: contentSizeWidth, height: myView?.frame.height ?? 0)
				myView?.collectionViewWidth = contentSizeWidth
				myView?.collectionView.reloadData()

		}.store(in: &disposables)
	}

}
