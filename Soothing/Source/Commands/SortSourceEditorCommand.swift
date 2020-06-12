import Foundation
import XcodeKit

class SortSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange
            else { return completionHandler(SelectionError.none) }

        let lines = invocation.buffer.lines.compactMap { $0 as? String }
        let range = selection.start.line...selection.end.line
        let sorted = lines[range].sorted()

        invocation.buffer.lines.replaceObjects(at: .init(range), with: sorted)
        completionHandler(nil)
    }
}
