//
//  FileSelectionViewController.swift
//  CSVReader
//
//  Created by Andrés Pesate on 12/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import Combine
import CommonUI

final class FileSelectionViewController: UIViewController, ViewProtocol, Titleable {

	let viewModel: FileSelectionViewModel
	
	private var myView: FileSelectionView! { view as? FileSelectionView }
	private var disposables: Set<AnyCancellable> = []
	private lazy var tableViewDataSource = makeDataSource()

	override func loadView() {
		view = FileSelectionView()
	}

	init(viewModel: FileSelectionViewModel = .init()) {
		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupComponents()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		bindDataSource()
		viewModel.refresh()
	}

	// MARK: Interface

	// MARK: Private

	private func setupComponents() {
		myView.tableView.register(FileSelectionTableViewCell.self, forCellReuseIdentifier: FileSelectionTableViewCell.className)
		myView.tableView.dataSource = tableViewDataSource
		myView.tableView.delegate = self
	}

}

// MARK: - TableView
private extension FileSelectionViewController {

	private typealias DataSource = UITableViewDiffableDataSource<Section, String>
	private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

	private enum Section {

		case main

	}

	private func makeDataSource() -> DataSource {
		let dataSource = DataSource(tableView: myView.tableView, cellProvider: cell(for:at:for:))
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		dataSource.apply(snapshot, animatingDifferences: false)

		return dataSource
	}

	private func cell(for tableView: UITableView, at indexPath: IndexPath, for model: String) -> UITableViewCell? {
		let cell = tableView.dequeueReusableCell(withIdentifier: FileSelectionTableViewCell.className, for: indexPath) as? FileSelectionTableViewCell
		cell?.fileNameLabel.text = model
		return cell
	}

	private func bindDataSource() {
		viewModel
			.$dataSource
			.sink { [weak tableViewDataSource] (files) in
				guard var snapshot = tableViewDataSource?.snapshot() else { return }
				snapshot.appendItems(files, toSection: .main)
				tableViewDataSource?.apply(snapshot, animatingDifferences: true)
		}
		.store(in: &disposables)
	}

}

extension FileSelectionViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
