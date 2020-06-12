//
//  FileSelectionViewModel.swift
//  CSVReader
//
//  Created by Andrés Pesate on 10/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import Foundation
import CSVReaderCore
import Combine

final class FileSelectionViewModel: ObservableObject {

	@Published var dataSource: [String] = []

	private var disposables: Set<AnyCancellable> = []
	private let fileExplorer: FileExplorer

	init(fileExplorer: FileExplorer = .init()) {
		self.fileExplorer = fileExplorer
	}

	// MARK: Interface

	func loadData() {
		do
		{
			let  paths = try fileExplorer.paths(forFilesOf: "csv")
			dataSource = paths.map({ $0.deletingPathExtension().lastPathComponent })

		} catch let FileExplorerError.filesNotFound(type) {
			print("No files found of type: \(type)")
		} catch {
			assertionFailure("Unsupported Error Type")
		}
	}

	// MARK: Private



}
