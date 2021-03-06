//
//  HistorySceneDIContainer.swift
//  WeBudget
//
//  Created by Maxime Maheo on 01/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit.UINavigationController
import BudgetService
import FormatterService

public final class HistorySceneDIContainer {
    
    public struct Dependencies {

        // MARK: - Properties
        
        let budgetService: BudgetServiceProtocol
        let formatterService: FormatterServiceProtocol
        
        // MARK: - Lifecycle

        public init(budgetService: BudgetServiceProtocol,
                    formatterService: FormatterServiceProtocol) {
            self.budgetService = budgetService
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
    
    public func makeCoordinator(navigationController: UINavigationController) -> HistorySceneCoordinator {
        HistorySceneCoordinator(navigationController: navigationController,
                                dependencies: self)
    }
}

// MARK: - HistorySceneCoordinatorDependencies -

extension HistorySceneDIContainer: HistorySceneCoordinatorDependencies {
    
    // MARK: - Properties
    
    var budgetService: BudgetServiceProtocol { dependencies.budgetService }
    var formatterService: FormatterServiceProtocol { dependencies.formatterService }
}
