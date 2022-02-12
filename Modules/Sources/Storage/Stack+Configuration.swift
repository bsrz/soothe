import Foundation

extension Stack {
    public struct Configuration {

        // MARK: - Properties
        public var name: String
        public var type: StoreType

        // MARK: - Initialization
        public init(name: String, type: Stack.Configuration.StoreType) {
            self.name = name
            self.type = type
        }

        // MARK: - Computed
        var filename: String { name + ".sqlite" }
        var directory: String { name + ".momd" }
    }
}

extension Stack.Configuration {
    public enum StoreType {
        case memory
        case disk(URL)
    }
}

extension Stack.Configuration {
    public static func disk(url: URL) -> Self { .init(name: "Storage", type: .disk(url)) }
    public static let memory: Self = .init(name: "Storage", type: .memory)
}

