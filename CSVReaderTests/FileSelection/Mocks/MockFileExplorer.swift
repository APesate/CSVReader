//
//  MockFileExplorer.swift
//  CSVReaderTests
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import Foundation
import CSVReaderCore

class MockFileExplorer: Explorer {

	var expectedPathsForFilesOfError: FileExplorerError?
	var expectedPathForFileError: FileExplorerError?
	var expectedPaths: [URL]?
	var expectedPath: URL?

	func paths(forFilesOf type: String, in bundle: Bundle) throws -> [URL] {
		if let error = expectedPathsForFilesOfError {
			throw error
		} else {
			precondition(expectedPaths != nil, "The mock object was not configured properly. Please set the value of 'expectedPaths'")
			return expectedPaths!
		}
	}

	func path(forFile name: String, withExtension type: String, in bundle: Bundle) throws -> URL {
		if let error = expectedPathForFileError {
			throw error
		} else {
			precondition(expectedPath != nil, "The mock object was not configured properly. Please set the value of 'expectedPath'")
			return expectedPath!
		}
	}

}
