//
//  MockContentDisplayBuilder.swift
//  CSVReaderTests
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit.UIViewController
@testable import CSVReader

class MockContentDisplayBuilder: ContentDisplayBuilder {

	var expectedViewController: UIViewController!

	override func build(forFileAt fileLocation: URL) -> UIViewController {
		precondition(expectedViewController != nil, "Mock wrongly configured. Please set a value for the expected view controller.")
		return expectedViewController!
	}

}
