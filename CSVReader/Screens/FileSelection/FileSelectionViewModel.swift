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
import UIKit.UIViewController

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

		} catch let FileExplorerError.noFilesFound(type) {
			print("No files found of type: \(type)")
		} catch {
			assertionFailure("Unsupported Error Type")
		}
	}

	func open(fileAt index: Int) -> UIViewController? {
		let fileName = dataSource[index]
		do {
			let path = try fileExplorer.path(forFile: fileName, withExtension: "csv")
			let destinationVM = ContentDisplayViewModel(fileLocation: path)

			return ContentDisplayViewController(viewModel: destinationVM)

		} catch FileExplorerError.fileNotFound {
			print("File not found: \(fileName).csv")
		} catch {
			assertionFailure("Unsupported Error Type")
		}

		return nil
	}

	// MARK: Private


}
