//
//  ViewProtocol.swift
//  CSVReader
//
//  Created by Andrés Pesate on 13/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import UIKit

protocol ViewProtocol {

	associatedtype ViewModel: ViewModelProtocol
	
	var viewModel: ViewModel { get }
	
}
