//
//  AppDelegate.swift
//  CSVReader
//
//  Created by Andrés Pesate on 10/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UIHostingController(rootView: SplashView())
		window?.makeKeyAndVisible()

		return true
	}

}
