import Foundation
import SoothingKit
import XcodeKit

class SortSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        let command = SortCommand()
        command.perform(with: invocation, completionHandler: completionHandler)
    }
}
