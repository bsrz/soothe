import Foundation
import XcodeKit

class SortSourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
            let userInfo = [NSLocalizedDescriptionKey: "This extension only works with a selection."]
            let error = NSError(domain: "\(#file) -> \(#function)", code: #line, userInfo: userInfo)
            return completionHandler(error)
        }

        let allLines = invocation.buffer.lines.compactMap { $0 as? String }
        let lines = allLines[selection.start.line...selection.end.line].sorted()
        let range = NSRange(location: selection.start.line, length: selection.end.line - selection.start.line + 1)
        invocation.buffer.lines.replaceObjects(in: range, withObjectsFrom: lines)
        completionHandler(nil)
    }
}
