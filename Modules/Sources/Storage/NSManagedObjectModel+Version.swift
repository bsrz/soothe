import Foundation

/// Represents a version of a CoreData model
struct Version: RawRepresentable {

    /// The name of the `.xcdatamodel` file, without the extension
    var rawValue: String
}
