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
import SwiftDI

final class ContentDisplayViewModel: ViewModelProtocol, Titleable {

	@Published var dataSource: [Record] = []
	@Published var isLoading: Bool = true
	@Published var error: CSVReaderError?

	@Localized private(set) var title: String = ""
	@Injected private(set) var fileReader: CSVFileReader<Record>
	private var disposables: Set<AnyCancellable> = []
	private let fileLocation: URL

	init(fileLocation: URL, fileReader: CSVFileReader<Record> = .init()) {
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
			.read(fileAt: fileLocation, progressListener: subject)
			.sink(receiveCompletion: { [weak self] (completion) in
				guard let self = self else { return }
				self.isLoading = false
				switch completion {
					case .failure(let error):
						self.error = error

					case .finished:
						self.error = nil
				}
			}, receiveValue: { [weak self] (records) in
				guard let self = self else { return }
				self.isLoading = false
				self.dataSource = records
			})
			.store(in: &disposables)
	}

}
