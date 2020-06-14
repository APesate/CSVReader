//
//  ContentDisplayViewModelTests.swift
//  CSVReaderTests
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import XCTest
@testable import CSVReader
import CSVReaderCore
import Combine

class ContentDisplayViewModelTests: XCTestCase {

	var sut: ContentDisplayViewModel!
	var mockCSVReader: MockCSVFileReader!

	let dummyFileLocation = URL(fileURLWithPath: "SomePath")
	var disposables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
		try super.setUpWithError()
		mockCSVReader = MockCSVFileReader()
		sut = ContentDisplayViewModel(fileLocation: dummyFileLocation, fileReader: mockCSVReader)
    }

    override func tearDownWithError() throws {
		sut = nil
		mockCSVReader = nil
		disposables.removeAll()
		try super.tearDownWithError()
    }

	func testLoadData_whenItsAbleToLoadTheContent_emitsLoadingStateUpdateEvents() {
		let expectation = XCTestExpectation(description: "Should emit 3 'isLoading' events")
		expectation.expectedFulfillmentCount = 3
		expectation.assertForOverFulfill = true
		let expectedSequence = [true, true, false]
		var eventsCount = 0
		mockCSVReader.expectedResult = [Record(from: [])]

		sut.$isLoading
			.sink { (value) in
				defer { eventsCount += 1}
				XCTAssertEqual(expectedSequence[eventsCount], value)
				expectation.fulfill()
		}
		.store(in: &disposables)

		sut.loadData()

		wait(for: [expectation], timeout: 1.0)
	}

	func testLoadData_whenAnErrorOccurs_emitsLoadingStateUpdateEvents() {
		let expectation = XCTestExpectation(description: "Should emit 3 'isLoading' events")
		expectation.expectedFulfillmentCount = 3
		expectation.assertForOverFulfill = true
		let expectedSequence = [true, true, false]
		var eventsCount = 0
		mockCSVReader.expectedError = .fileNotFound

		sut.$isLoading
			.sink { (value) in
				defer { eventsCount += 1}
				XCTAssertEqual(expectedSequence[eventsCount], value)
				expectation.fulfill()
		}
		.store(in: &disposables)

		sut.loadData()

		wait(for: [expectation], timeout: 1.0)
	}

	func testLoadData_whenAnErrorOccurs_emitsErrorEvents() {
		let expectation = XCTestExpectation(description: "Should emit nil 'error' event")
		let expectedError = CSVReaderError.fileNotFound
		mockCSVReader.expectedError = expectedError

		sut.$error
			.throttle(for: 1, scheduler: RunLoop.main, latest: true)
			.sink(receiveValue: { (error) in
				expectation.fulfill()
				XCTAssertEqual(error, expectedError)
			})
			.store(in: &disposables)

		sut.loadData()

		wait(for: [expectation], timeout: 1.0)
	}

	func testLoadData_whenItsAbleToLoadTheContent_emitsDataSourceUpdateEvent() {
		let expectation = XCTestExpectation(description: "Should update 'dataSource'")
		let expectedResult = [Record(from: ["Some"])]
		mockCSVReader.expectedResult = expectedResult

		sut.$dataSource
			.throttle(for: 1, scheduler: RunLoop.main, latest: true)
			.sink(receiveValue: { (result) in
				expectation.fulfill()
				XCTAssertEqual(result, expectedResult)
			})
			.store(in: &disposables)

		sut.loadData()

		wait(for: [expectation], timeout: 1.0)
	}

	func testLoadData_whenItsAbleToLoadTheContent_emitsNilErrorEvent() {
		let expectation = XCTestExpectation(description: "Should emit nil 'error' event")
		let expectedResult = [Record(from: ["Some"])]
		mockCSVReader.expectedResult = expectedResult

		sut.$error
			.throttle(for: 1, scheduler: RunLoop.main, latest: true)
			.sink(receiveValue: { (error) in
				expectation.fulfill()
				XCTAssertNil(error)
			})
			.store(in: &disposables)

		sut.loadData()

		wait(for: [expectation], timeout: 1.0)
	}

}
