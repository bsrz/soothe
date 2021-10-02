import Foundation

public struct TextSelection {
    public var column: Int
    public var line: Int

    public init(column: Int, line: Int) {
        self.column = column
        self.line = line
    }
}
