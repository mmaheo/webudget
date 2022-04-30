//
//  TransactionScene.swift
//  WeBudget
//
//  Created by Maxime Maheo on 30/04/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct TransactionScene: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: TransactionSceneViewModel
    
    // MARK: - Body
    
    var body: some View {
        Text("Hello, World")
    }
}

#if DEBUG

struct TransactionScene_Previews: PreviewProvider {
    static var previews: some View {
        TransactionScene(viewModel: TransactionSceneViewModel.preview)
    }
}

#endif
