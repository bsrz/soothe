import Foundation
import XcodeKit

class InterpolateSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        guard
            let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange,
            var line = invocation.buffer.lines[selection.start.line] as? String
            else { return completionHandler(SelectionError.empty) }

        guard selection.start.line == selection.end.line else {
            return completionHandler(SelectionError.multi)
        }

        line.insert(")", at: line.index(line.startIndex, offsetBy: selection.end.column))
        line.insert("(", at: line.index(line.startIndex, offsetBy: selection.start.column))
        line.insert(#"\"#, at: line.index(line.startIndex, offsetBy: selection.start.column))
        invocation.buffer.lines.replaceObject(at: selection.start.line, with: line)

        selection.start.column += 2
        selection.end.column += 2

        completionHandler(nil)
    }
}
