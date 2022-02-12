@testable import Storage
import XCTest

final class StackConfigurationTests: XCTestCase {
    func testConfig_returnsExpectedFilenameAndDirectory() async throws {
        // Arrange & Act
        let sut = Stack.Configuration(name: "foo", type: .memory)

        // Assert
        XCTAssertEqual(sut.filename, "foo.sqlite")
        XCTAssertEqual(sut.directory, "foo.momd")
    }

    func testConfig_presetsHaveExpectedNames() async throws {
        // Arrange & Act
        let memory = Stack.Configuration.memory
        let disk = Stack.Configuration.disk(url: FileManager.default.temporaryDirectory)

        // Assert
        XCTAssertEqual(memory.name, "Storage")
        XCTAssertEqual(disk.name, "Storage")
    }
}
