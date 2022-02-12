@testable import Storage
import XCTest

final class StackTests: XCTestCase {

    func testStack() async throws {
        // Arrange
        let manager: FileManager = .default
        let uuid = UUID()
        let url = manager.temporaryDirectory.appendingPathComponent(uuid.uuidString, isDirectory: true)

        try manager.createDirectory(at: url, withIntermediateDirectories: true)

        print("url: \(url)")

        let config: Stack.Configuration = .disk(url: url)
        let sut = Stack(configuration: config, model: .model(subdirectory: config.directory))

        // Act
        let pat = PersonalAccessToken(context: sut.context)
        pat.token = "foobarqux"

        try sut.save()

        // Assert
        let request = PersonalAccessToken.fetchRequest()
        let output = try sut.context.fetch(request)

        XCTAssertEqual(output.count, 1)
        XCTAssertEqual(output.first?.token, "foobarqux")
    }
}
