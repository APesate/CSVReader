//
//  DependencyManager.swift
//  CSVReader
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import Foundation
import SwiftDI
import CSVReaderCore

struct DependencyManager {

	func registerDependencies() {
		SwiftDI.configure {
			$0.single({ FileSelectionViewModel() })
			$0.single({ FileExplorer() })
			$0.single({ CSVFileReader<Record>() })
		}
	}

}
