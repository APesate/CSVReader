//
//  ContentDisplayViewModel.swift
//  CSVReader
//
//  Created by Andrés Pesate on 10/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import Foundation
import Combine
import CSVReaderCore
import CommonUI

final class ContentDisplayViewModel: ViewModelProtocol, Titleable {

	@Published var dataSource: [[Record]] = []
	@Published var isLoading: Bool = false

	@Localized private(set) var title: String = ""
	private var disposables: Set<AnyCancellable> = []
	private let fileLocation: URL
	private let fileReader: CSVFileReader

	init(fileLocation: URL, fileReader: CSVFileReader = .init()) {
		self.fileLocation = fileLocation
		self.fileReader = fileReader
		self.title = fileLocation.lastPathComponent
	}

	// MARK: Interface

	func loadData() {
		let subject = PassthroughSubject<Int, Never>()

		isLoading = true

		subject.sink { (progress) in
			print(progress)
		}.store(in: &disposables)

		fileReader
			.read(fileAt: fileLocation.path, progressListener: subject)
			.map({ (records) -> [[Record]] in
				records.map { (row) -> [Record] in
					row.map({ content in
						Record(content: content)
					})
				}
			})
			.sink(receiveCompletion: { (completion) in
				switch completion {
					case .failure(let error):
						print(error)

					case .finished:
						print("finished")
				}
			}, receiveValue: { [weak self] (records) in
				guard let self = self else { return }
				self.isLoading = false
				self.dataSource = records
			})
			.store(in: &disposables)
	}


}
