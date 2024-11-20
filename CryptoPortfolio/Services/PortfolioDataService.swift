//
//  PortfolioDataService.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 30.10.2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    //MARK: - Properties
    private let container: NSPersistentContainer
    private let entityName = "Portfolio"
    @Published var savedEntities: [Portfolio] = []
    
    //MARK: - Init
    init() {
        container = NSPersistentContainer(name: "PortfolioContainer")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: - Methods
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio: \(error.localizedDescription) ")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = Portfolio(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: Portfolio, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: Portfolio) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving portfolio: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
