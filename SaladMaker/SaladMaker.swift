//
//  SaladMaker.swift
//  SaladMaker
//
//  Created by Anurag Ajwani on 12/12/2020.
//

import Foundation

class SaladBowl {
    var ingredients: [Ingredient] = []
}

class SaladMaker {

    func make(onIngrdientPrepped: @escaping (Ingredient) -> (), onCompletion completionHandler: @escaping () -> ()) {
        let saladBowl = SaladBowl()
        let ingredients: [Ingredient] = [.lettuce, .tomatoes, .redOnion, .sweetcorn, .tuna] //1 List ingredients in order
        var operations: [Operation] = []
        for (index, ingredient) in ingredients.enumerated() {
            let operation = IngredientPrepper(saladBowl: saladBowl, ingredient: ingredient) // 2 create operation for each ingredient
            operation.completionBlock = {
                onIngrdientPrepped(ingredient)
            }
            if index > 0 { // 3 add previous ingredient operation as dependency (except for the first one (lettuce)
                let previousOperation = operations[index - 1]
                operation.addDependency(previousOperation)
            }
            operations.append(operation)
        }
        let operationQueue = OperationQueue() // 4 create operation queue
        operationQueue.maxConcurrentOperationCount = 1 // 7
        operationQueue.addOperations(operations, waitUntilFinished: false) // 5
        operationQueue.addBarrierBlock {
            // 6 handling completion of all operations
            completionHandler()
        }
    }
}

class IngredientPrepper: Operation {
    
    private let saladBowl: SaladBowl
    private let ingredient: Ingredient
    
    init(saladBowl: SaladBowl, ingredient: Ingredient) {
        self.saladBowl = saladBowl
        self.ingredient = ingredient
    }
    
    override func main() {
        sleep(1)
        self.saladBowl.ingredients.append(self.ingredient)
    }
}
