//
//  ContentDisplayBuilder.swift
//  CSVReader
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import CSVReaderCore

class ContentDisplayBuilder {

	func build(forFileAt fileLocation: URL) -> UIViewController {
		return ContentDisplayViewController(viewModel: viewModel(withFileAt: fileLocation))
	}

	private func viewModel(withFileAt fileLocation: URL) -> ContentDisplayViewModel {
		return ContentDisplayViewModel(fileLocation: fileLocation, fileReader: csvFileReader())
	}

	private func csvFileReader() -> CSVFileReader<Record> {
		return CSVFileReader()
	}

}
