import CoreData

extension NSManagedObjectModel {

    /// Returns an array of URLs representing each version for a given `xcdatamodeld` directory
    /// - Parameters:
    ///   - subdirectory: The name of the `.momd` directory; must include the extension
    ///   - bundle: The bundle to search
    /// - Returns: An array of URLs
    private static func urls(subdirectory: String, in bundle: Bundle = .module) -> [URL] {
        return bundle.urls(
            forResourcesWithExtension: "mom",
            subdirectory: subdirectory
        ) ?? []
    }

    /// Returns an array of `NSManagedObjectModel` representing each version
    /// - Parameter subdirectory: The name of the `.momd` directory; must include the extension
    /// - Returns: An array of managed object models
    static func models(subdirectory: String, in bundle: Bundle = .module) -> [NSManagedObjectModel] {
        return urls(subdirectory: subdirectory, in: bundle)
            .compactMap(NSManagedObjectModel.init)
    }

    /// Returns a managed object model for a given version
    /// - Parameter version: The version of the managed object model
    /// - Returns: A managed object model
    static func model(subdirectory: String, version: Version) -> NSManagedObjectModel {
        return urls(subdirectory: subdirectory)
            .first { $0.lastPathComponent == "\(version.rawValue).mom" }
            .flatMap(NSManagedObjectModel.init)
            ?? .init()
    }

    /// Returns a managed object model created from the top level directoy
    /// - Parameters:
    ///   - subdirectory: The name of the `.momd` directory; including the extension
    ///   - bundle: The bundle to search
    /// - Returns: A managed object model
    static func model(subdirectory: String, in bundle: Bundle = .module) -> NSManagedObjectModel {
        return bundle
            .url(forResource: subdirectory, withExtension: nil)
            .flatMap(NSManagedObjectModel.init)
            ?? .init()
    }

    /// Compares two models using `entitiesByName`
    /// - Parameters:
    ///   - first: The first object model
    ///   - second: The second object model
    /// - Returns: `true` if `entitiesByName` are the same, `false` otherwise
    static func ==(_ first: NSManagedObjectModel, _ second: NSManagedObjectModel) -> Bool {
        first.entitiesByName == second.entitiesByName
    }
}
