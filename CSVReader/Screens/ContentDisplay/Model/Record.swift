//
//  Record.swift
//  CSVReader
//
//  Created by Andrés Pesate on 13/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import Foundation
import CSVReaderCore

struct Record: Identifiable, Hashable, CSVImportable {
	var id = UUID()
	let values: [String]

	init(from values: [String]) {
		self.values = values
	}

	static func == (lhs: Record, rhs: Record) -> Bool {
		return lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
