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
	@Published var error: FileExplorerError?

	@Localized private(set) var title: String = "file_explorer_title"
	private var fileExplorer: Explorer
	private var contentDisplayBuilder: ContentDisplayBuilder

	init(fileExplorer: Explorer, contentDisplayBuilder: ContentDisplayBuilder) {
		self.fileExplorer = fileExplorer
		self.contentDisplayBuilder = contentDisplayBuilder
	}

	// MARK: Interface

	func refresh() {
		do {
			let paths = try fileExplorer.paths(forFilesOf: "csv", in: .main)
			error = nil
			dataSource = paths.map({ $0.deletingPathExtension().lastPathComponent })

		} catch let error as FileExplorerError {
			self.error = error

		} catch {
			assertionFailure("Unsupported Error Type")
		}
	}

	func open(fileAt index: Int) -> UIViewController? {
		let fileName = dataSource[index]

		do {
			let path = try fileExplorer.path(forFile: fileName, withExtension: "csv", in: .main)

			return contentDisplayBuilder.build(forFileAt: path)

		} catch let error as FileExplorerError {
			self.error = error

		} catch {
			assertionFailure("Unsupported Error Type")
		}

		return nil
	}

	// MARK: Private

}
