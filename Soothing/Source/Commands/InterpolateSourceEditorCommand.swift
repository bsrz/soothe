import Foundation
import SoothingKit
import XcodeKit

class InterpolateSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        let command = InterpolateCommand()
        command.perform(with: invocation, completionHandler: completionHandler)
    }
}
