//
//  DatabaseService.swift
//  
//
//  Created by Maxime Maheo on 01/05/2022.
//

import CoreData
import Model

public protocol DatabaseServiceProtocol {
    func save(transaction: Transaction)
    func fetchTransactions() -> [Transaction]
    func delete(transactions: [Transaction])
    
    func save(tag: Tag)
    func fetchTags() -> [Tag]
    func delete(tags: [Tag])
}

public final class DatabaseService: DatabaseServiceProtocol {
    
    // MARK: - Properties
    
    private var persistentContainer: NSPersistentContainer!
    private var context: NSManagedObjectContext!
    
    // MARK: - Lifecycle
    
    public init() {
        initDatabase()
    }
    
    public func save(transaction: Transaction) {
        create(transaction: transaction)
        
        saveIfNeeded()
    }
    
    public func fetchTransactions() -> [Transaction] {
        let fetchRequest: NSFetchRequest<CDTransaction> = NSFetchRequest(entityName: "\(CDTransaction.self)")
        
        do {
            let transactions = try context.fetch(fetchRequest)
            
            return transactions
                .compactMap { Transaction(transaction: $0) }
                .sorted(by: { $0.date > $1.date })
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func delete(transactions: [Transaction]) {
        let fetchRequest: NSFetchRequest<CDTransaction> = NSFetchRequest(entityName: "\(CDTransaction.self)")
        
        do {
            let allTransactions = try context.fetch(fetchRequest)
            allTransactions
                .filter { cdTransaction in
                    transactions.contains { cdTransaction.id == $0.id }
                }
                .forEach {
                    context.delete($0)
                }
            
            saveIfNeeded()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func save(tag: Tag) {
        create(tag: tag)
        
        saveIfNeeded()
    }
    
    public func fetchTags() -> [Tag] {
        let fetchRequest: NSFetchRequest<CDTag> = NSFetchRequest(entityName: "\(CDTag.self)")
        
        do {
            let tags = try context.fetch(fetchRequest)
            
            return tags
                .compactMap { Tag(tag: $0) }
                .sorted(by: { $0.transactionsCount > $1.transactionsCount })
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func delete(tags: [Tag]) {
        let fetchRequest: NSFetchRequest<CDTag> = NSFetchRequest(entityName: "\(CDTag.self)")
        
        do {
            let allTags = try context.fetch(fetchRequest)
            allTags
                .filter { cdTag in
                    tags.contains { cdTag.id == $0.id }
                }
                .forEach {
                    context.delete($0)
                }
            
            saveIfNeeded()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Private methods
    
    private func initDatabase() {
        guard let modelUrl = Bundle.module.url(forResource: "Model", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelUrl)
        else { fatalError("Could not init DatabaseService") }
        
        persistentContainer = NSPersistentContainer(name: "Model", managedObjectModel: model)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
        context = persistentContainer.newBackgroundContext()
    }
    
    private func saveIfNeeded() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @discardableResult
    private func create(tag: Tag) -> CDTag {
        let newTag = CDTag(context: context)
        newTag.id = tag.id
        newTag.value = tag.value
        
        return newTag
    }
    
    @discardableResult
    private func create(transaction: Transaction) -> CDTransaction {
        let newTransaction = CDTransaction(context: context)
        newTransaction.id = transaction.id
        newTransaction.value = Int64(transaction.value)
        newTransaction.date = transaction.date
        newTransaction.isExpense = transaction.isExpense
        
        if let tag = transaction.tag {
            let fetchRequest: NSFetchRequest<CDTag> = NSFetchRequest(entityName: "\(CDTag.self)")
            fetchRequest.predicate = NSPredicate(format: "id == %@", tag.id.uuidString)
            
            let tag = try? context.fetch(fetchRequest).first
            
            newTransaction.tag = tag
        }

        return newTransaction
    }
}
