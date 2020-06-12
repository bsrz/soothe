import Foundation
import SoothingKit
import XcodeKit

class AlignSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        let command = AlignCommand()
        command.perform(with: invocation, completionHandler: completionHandler)
    }
}
