import Foundation
import XcodeKit

class InterpolateSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        guard
            let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange,
            var line = invocation.buffer.lines[selection.start.line] as? String
            else { return completionHandler(InterpolateError.noSelection) }

        guard selection.start.line == selection.end.line else {
            return completionHandler(InterpolateError.multilineSelection)
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

enum InterpolateError: Error {
    case noSelection
    case multilineSelection

    var localizedDescription: String {
        switch self {
        case .noSelection: return "This command only works when you have a single text selection."
        case .multilineSelection: return "This command only works when you have a single text selection."
        }
    }
}
