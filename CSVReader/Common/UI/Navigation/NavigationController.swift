//
//  NavigationController.swift
//  CSVReader
//
//  Created by Andrés Pesate on 12/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

	override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme()
		delegate = self
	}

}

// MARK: UINavigationControllerDelegate
extension NavigationController: UINavigationControllerDelegate {

	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		viewController.title = (viewController as? Titleable)?.title
	}

}

extension NavigationController {

	private func applyTheme() {
		themeNavigationBar()
	}

	private func themeNavigationBar() {
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithOpaqueBackground()
		navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .headline)]
		navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .largeTitle)]
		navBarAppearance.backgroundColor = .raboBlue

		navigationBar.prefersLargeTitles = true
		navigationBar.tintColor = .raboOrange
		navigationBar.standardAppearance = navBarAppearance
		navigationBar.scrollEdgeAppearance = navBarAppearance
	}

}
