import CoreData
import Foundation

public class Stack {

    // MARK: - Properties
    private let configuration: Configuration
    private let model: NSManagedObjectModel

    // MARK: - Lazy Properties
    private lazy var container: NSPersistentContainer = {
        let desc = NSPersistentStoreDescription()
        if case .disk(let url) = configuration.type {
            desc.url = .init(fileURLWithPath: configuration.filename, relativeTo: url)
            desc.type = NSSQLiteStoreType
        } else {
            desc.type = NSInMemoryStoreType
        }

        let container = NSPersistentContainer(name: configuration.name, managedObjectModel: model)
        container.persistentStoreDescriptions = [desc]
        container.loadPersistentStores { desc, error in
            guard error == nil else {
                fatalError("Unable to load persistent stores, error: \(error!)")
            }

            print("Succesfully loaded store: \(desc.description)")
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return container
    }()

    // MARK: - Initializer
    public init(configuration: Configuration, model: NSManagedObjectModel) {
        self.configuration = configuration
        self.model = model
    }

    // MARK: - Context
    public var context: NSManagedObjectContext { container.viewContext }
    public var makeBackgroundContext: NSManagedObjectContext { container.newBackgroundContext() }
    public func save() throws {
        guard context.hasChanges else {
            return print("The context has not changes, nothing to save")
        }

        try context.save()
    }
}
