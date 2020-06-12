//
//  NavigationController.swift
//  CSVReader
//
//  Created by Andrés Pesate on 12/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationBar.prefersLargeTitles = true
		delegate = self
	}

}

// MARK: UINavigationControllerDelegate
extension NavigationController: UINavigationControllerDelegate {

	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		viewController.title = (viewController as? Titleable)?.title
	}

}
