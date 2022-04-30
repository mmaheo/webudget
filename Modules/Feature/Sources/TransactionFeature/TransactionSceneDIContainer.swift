//
//  TransactionSceneDIContainer.swift
//  WeBudget
//
//  Created by Maxime Maheo on 30/04/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import FormatterService
import UIKit.UINavigationController

public final class TransactionSceneDIContainer {
    
    public struct Dependencies {

        // MARK: - Properties
        
        let formatterService: FormatterServiceProtocol

        // MARK: - Lifecycle

        public init(formatterService: FormatterServiceProtocol) {
            self.formatterService = formatterService
        }
    }
    
    // MARK: - Properties
    
    private let dependencies: Dependencies
    
    // MARK: - Lifecycle
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    
    public func makeCoordinator(navigationController: UINavigationController) -> TransactionSceneCoordinator {
        TransactionSceneCoordinator(navigationController: navigationController,
                                    dependencies: self)
    }
}

// MARK: - TransactionSceneCoordinatorDependencies -

extension TransactionSceneDIContainer: TransactionSceneCoordinatorDependencies {
    
    // MARK: - Properties
    
    var formatterService: FormatterServiceProtocol { dependencies.formatterService }

}