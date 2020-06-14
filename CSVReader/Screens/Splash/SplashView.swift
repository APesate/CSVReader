//
//  SplashView.swift
//  CSVReader
//
//  Created by Andrés Pesate on 14/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import SwiftUI
import CommonUI
import UIKit

struct SplashView: View {
	@State var timeOutInSeconds = 2
	let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

	var body: some View {
		HStack {
			Spacer()
			VStack {
				Spacer()
				titleText
				subtitleText
				Spacer()
			}
			Spacer()
		}
		.preferredColorScheme(.dark)
		.background(SwiftUI.Color(.raboBlue).edgesIgnoringSafeArea(.all))
	}

	var titleText: some View {
		Text("CSVReader")
			.font(.largeTitle)
			.foregroundColor(Color(.raboOrange))
			.onReceive(timer) { _ in
				guard self.timeOutInSeconds == 0 else {
					self.timeOutInSeconds -= 1
					return
				}
				self.timer.upstream.connect().cancel()
				self.navigateToRootViewController()
		}
	}

	var subtitleText: some View {
		Text("splash_message".localized)
			.foregroundColor(Color(.white))
			.font(.headline)
	}

	// MARK: Private

	private func navigateToRootViewController() {
		let transition = CATransition()
		transition.duration = CFTimeInterval(0.5)
		transition.type = CATransitionType.fade
		transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

		UIApplication.shared.keyWindow?.layer.add(transition, forKey: nil)
		UIApplication.shared.keyWindow?.rootViewController = NavigationController(rootViewController: FileSelectionBuilder().build())
	}

}

struct SplashView_Previews: PreviewProvider {
	static var previews: some View {
		SplashView()
	}
}
