//
//  FileSelectionBuilder.swift
//  CSVReader
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import CSVReaderCore

class FileSelectionBuilder {

	private let contentDisplayBuilder = ContentDisplayBuilder()

	func build() -> UIViewController {
		return FileSelectionViewController(viewModel: viewModel())
	}

	private func viewModel() -> FileSelectionViewModel {
		return FileSelectionViewModel(fileExplorer: fileExplorer(), contentDisplayBuilder: contentDisplayBuilder)
	}

	private func fileExplorer() -> Explorer {
		return FileExplorer()
	}

}
