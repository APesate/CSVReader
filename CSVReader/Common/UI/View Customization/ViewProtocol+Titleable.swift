//
//  ViewProtocol+Titleable.swift
//  CSVReader
//
//  Created by Andrés Pesate on 13/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit

extension ViewProtocol where Self: UIViewController, Self.ViewModel: Titleable {

	var title: String {
		viewModel.title
	}

}
