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
import CommonUI

final class FileSelectionViewModel: ViewModelProtocol, Titleable {

	@Published var dataSource: [String] = []

	@Localized private(set) var title: String = "Documents"

	private var disposables: Set<AnyCancellable> = []
	private let fileExplorer: FileExplorer

	init(fileExplorer: FileExplorer = .init()) {
		self.fileExplorer = fileExplorer
	}

	// MARK: Interface

	func refresh() {
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
