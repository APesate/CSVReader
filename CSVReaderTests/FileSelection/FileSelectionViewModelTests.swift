//
//  FileSelectionViewModelTests.swift
//  CSVReaderTests
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import XCTest
@testable import CSVReader
import Combine
import CSVReaderCore

class FileSelectionViewModelTests: XCTestCase {

	var sut: FileSelectionViewModel!
	var mockFileExplorer: MockFileExplorer!
	private var disposables: Set<AnyCancellable> = []

	override func setUpWithError() throws {
		try super.setUpWithError()
		self.mockFileExplorer = MockFileExplorer()
		self.sut = FileSelectionViewModel(fileExplorer: mockFileExplorer)
	}

	override func tearDownWithError() throws {
		mockFileExplorer = nil
		sut = nil
		disposables.removeAll()
		try super.tearDownWithError()
	}

	// MARK: Tests

	func testRefresh_whenThereArentAnyCSVFiles_emitsNoFilesFoundErrorEvent() {
		let expectedFileType = "csv"
		mockFileExplorer.expectedPathsForFilesOfError = FileExplorerError.noFilesFound(type: expectedFileType)
		let expectation = XCTestExpectation(description: "'error' publisher should emit an event.")

		sut.$error
			.throttle(for: 1, scheduler: RunLoop.main, latest: true)
			.sink(receiveValue: { (error) in
				XCTAssertNotNil(error)
				XCTAssertEqual(error, FileExplorerError.noFilesFound(type: expectedFileType))
				expectation.fulfill()
			})
			.store(in: &disposables)

		sut.refresh()

		wait(for: [expectation], timeout: 1.0)
	}

	func testRefresh_whenThereAreCSVFiles_emitsDataSourceUpdateEvent() {
		let expectedPaths = (0...5).map({ URL(fileURLWithPath: String($0)) })
		let expectedResults = expectedPaths.map({ $0.lastPathComponent })
		mockFileExplorer.expectedPaths = expectedPaths
		let expectation = XCTestExpectation(description: "'dataSource' publisher should emit an event.")

		sut.$dataSource
			.throttle(for: 1, scheduler: RunLoop.main, latest: true)
			.sink(receiveValue: { result in
				XCTAssertEqual(result, expectedResults)
				expectation.fulfill()
			})
			.store(in: &disposables)

		sut.refresh()

		wait(for: [expectation], timeout: 1.0)
	}

	func testOpenFileAt_whenTheFileWasNotFound_emitsFileNotFoundErrorEvent() {
		mockFileExplorer.expectedPathForFileError = FileExplorerError.fileNotFound
		let mockFileIndex = 0
		let expectedFilePaths = (0...5).map({ URL(fileURLWithPath: String($0)) })
		mockFileExplorer.expectedPaths = expectedFilePaths
		mockFileExplorer.expectedPath = expectedFilePaths.first
		let expectation = XCTestExpectation(description: "'error' publisher should emit an event.")

		sut.$error
			.throttle(for: 1, scheduler: RunLoop.main, latest: true)
			.sink(receiveValue: { (error) in
				XCTAssertNotNil(error)
				XCTAssertEqual(error, FileExplorerError.fileNotFound)
				expectation.fulfill()
			})
			.store(in: &disposables)

		sut.refresh()

		XCTAssertNil(sut.open(fileAt: mockFileIndex))

		wait(for: [expectation], timeout: 1.0)
	}

	func testOpenFileAt_whenFileIsAvailable_returnsDestinationViewController() {
		let mockFileIndex = 0
		let expectedFilePaths = (0...5).map({ URL(fileURLWithPath: String($0)) })
		mockFileExplorer.expectedPaths = expectedFilePaths
		mockFileExplorer.expectedPath = expectedFilePaths.first

		sut.refresh()
		let destinationVC = sut.open(fileAt: mockFileIndex)
		XCTAssertNotNil(destinationVC)

		guard let contentDisplayVC = destinationVC as? ContentDisplayViewController else {
			XCTFail("The destination view controller was expected to be of the type 'ContentDisplayViewController'")
			return
		}

		XCTAssertEqual(contentDisplayVC.viewModel.fileLocation, expectedFilePaths[mockFileIndex])
	}

}
