//
//  HistoryScene.swift
//  WeBudget
//
//  Created by Maxime Maheo on 01/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HistoryScene: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: HistorySceneViewModel
    
    // MARK: - Body
    
    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.models) {
                        TransactionComponent(model: $0)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(at: indexSet,
                                         sectionId: section.id)
                    }
                }
            }
        }
        .toolbar { EditButton() }
        .listStyle(InsetGroupedListStyle())
        .onAppear { viewModel.fetchTransactions() }
    }
}

#if DEBUG

struct HistoryScene_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScene(viewModel: HistorySceneViewModel.preview)
    }
}

#endif
