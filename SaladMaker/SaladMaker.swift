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
        LettucePrepper().prep(saladBowl, onCompletion: { saladBowl in
            onIngrdientPrepped(.lettuce)
            TomatoesPrepper().prep(saladBowl, onCompletion: { saladBowl in
                onIngrdientPrepped(.tomatoes)
                RedOnionPrepper().prep(saladBowl, onCompletion: { saladBowl in
                    onIngrdientPrepped(.redOnion)
                    SweetcornPrepper().prep(saladBowl, onCompletion: { saladBowl in
                        onIngrdientPrepped(.sweetcorn)
                        TunaPrepper().prep(saladBowl, onCompletion: { saladBowl in
                            onIngrdientPrepped(.tuna)
                            completionHandler()
                        })
                    })
                })
            })
        })
    }
}

class LettucePrepper {

    func prep(_ saladBowl: SaladBowl, onCompletion completionHandler: @escaping (SaladBowl) -> ()) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.0) {
            saladBowl.ingredients.append(.lettuce)
            completionHandler(saladBowl)
        }
    }
}

class TomatoesPrepper {
    
    let dispatchQueue = DispatchQueue(label: "com.saladmaker.app.tomatoes_prepper")
    
    func prep(_ saladBowl: SaladBowl, onCompletion completionHandler: @escaping (SaladBowl) -> ()) {
        self.dispatchQueue.asyncAfter(deadline: .now() + 1.0) {
            saladBowl.ingredients.append(.tomatoes)
            completionHandler(saladBowl)
        }
    }
}

class RedOnionPrepper {

    func prep(_ saladBowl: SaladBowl, onCompletion completionHandler: @escaping (SaladBowl) -> ()) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.0) {
            saladBowl.ingredients.append(.redOnion)
            completionHandler(saladBowl)
        }
    }
}

class SweetcornPrepper {
    
    func prep(_ saladBowl: SaladBowl, onCompletion completionHandler: @escaping (SaladBowl) -> ()) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.0) {
            saladBowl.ingredients.append(.sweetcorn)
            completionHandler(saladBowl)
        }
    }
}

class TunaPrepper {

    func prep(_ saladBowl: SaladBowl, onCompletion completionHandler: @escaping (SaladBowl) -> ()) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.0) {
            saladBowl.ingredients.append(.tuna)
            completionHandler(saladBowl)
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
