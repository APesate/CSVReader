//
//  MockCSVFileReader.swift
//  CSVReaderTests
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import Foundation
import CSVReaderCore
import Combine
@testable import CSVReader

class MockCSVFileReader: CSVFileReader<CSVReader.Record> {

	var expectedError: CSVReaderError?
	var expectedResult: [CSVReader.Record]?

	override func read(fileAt fileURL: URL, progressListener: PassthroughSubject<Int, Never>?) -> Future<[CSVReader.Record], CSVReaderError> {
		Future { [weak self] (promise) in
			guard let self = self else { return }

			if let error = self.expectedError {
				promise(.failure(error))
			} else {
				precondition(self.expectedResult != nil, "The mock is not configured correctly. Please give a value to the 'expectedResult'")
				progressListener?.send(0)
				promise(.success(self.expectedResult!))
			}
		}
	}

}
