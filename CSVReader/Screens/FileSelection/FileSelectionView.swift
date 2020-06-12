//
//  FileSelectionView.swift
//  CSVReader
//
//  Created by Andrés Pesate on 11/06/2020.
//  Copyright © 2020 Pesate. All rights reserved.
//

import SwiftUI

struct FileSelectionView: View {

	@ObservedObject private var viewModel = FileSelectionViewModel()

	init(viewModel: FileSelectionViewModel = .init()) {
		self.viewModel = viewModel
		viewModel.loadData()
	}

	var body: some View {
		List(viewModel.dataSource) { file in
			Text(file)
		}
	}
	
}

struct FileSelectionView_Previews: PreviewProvider {
	static var previews: some View {
		FileSelectionView()
	}
}
