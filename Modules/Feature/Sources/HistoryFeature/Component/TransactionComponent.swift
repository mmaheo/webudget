//
//  TransactionComponent.swift
//  
//
//  Created by Maxime Maheo on 01/05/2022.
//

import SwiftUI

struct TransactionComponent: View {
    
    struct Model: Identifiable {
        let id: UUID
        let value: String
        let date: String
        let isExpense: Bool
    }
    
    // MARK: - Properties
    
    let model: Model
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 4) {
            Text(model.isExpense ? "-" : "+")
                .font(.headline)
                .foregroundColor(model.isExpense ? .red : .green)
            
            Text(model.value)
                .font(.headline)
            
            Spacer()
            
            Text(model.date)
                .foregroundColor(.secondary)
        }
    }
}

#if DEBUG

struct TransactionComponent_Previews: PreviewProvider {
    static var previews: some View {
        TransactionComponent(model: TransactionComponent.Model(id: UUID(),
                                                               value: "$ 5",
                                                               date: "May 1",
                                                               isExpense: true))
        .previewLayout(.fixed(width: 375,
                              height: 60))
    }
}

#endif