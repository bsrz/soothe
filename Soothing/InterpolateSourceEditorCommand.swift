import Foundation
import XcodeKit

class InterpolateSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        let range = invocation.buffer.selections.firstObject as? XCSourceTextRange
        guard
            let start = range?.start,
            let end = range?.end,
            start.line == end.line,
            invocation.buffer.lines.count >= end.line,
            var line = invocation.buffer.lines[start.line] as? String
            else {
                let userInfo = [NSLocalizedDescriptionKey: "This extension works only with a single selection, on a single line."]
                let error = NSError(domain: #function, code: #line, userInfo: userInfo)
                return completionHandler(error)
            }

        let endIndex = line.index(line.startIndex, offsetBy: end.column)
        line.insert(")", at: endIndex)

        let startIndex = line.index(line.startIndex, offsetBy: start.column)
        line.insert(contentsOf: ["\\", "("], at: startIndex)

        invocation.buffer.lines.replaceObject(at: start.line, with: line)
        completionHandler(nil)
    }
}
