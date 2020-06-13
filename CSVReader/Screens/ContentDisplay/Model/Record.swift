//
//  Record.swift
//  CSVReader
//
//  Created by Andrés Pesate on 13/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import Foundation

struct Record: Identifiable, Hashable {
	var id = UUID()
	let content: String

	init(content: String) {
		self.content = content
	}

	static func ==(lhs: Record, rhs: Record) -> Bool {
		return lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
