import Foundation
import XcodeKit

// [@bsarrazin] Jun 11, 2020
// Credit for this extension goes to https://github.com/tid-kijyun/XcodeSourceEditorExtension-Alignment
// I have simply modified the code to make it more readable and more accurate.

public struct AlignCommand {

    // MARK: - Initialization
    public init() { }

    public func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange
            else { return completionHandler(SelectionError.none) }

        let regex = try! NSRegularExpression(
            pattern: "[^+^%^*^^^<^>^&^|^?^=^-](\\s*)(=)[^=]",
            options: .caseInsensitive
        )

        guard let position = invocation.buffer.lines
            .enumerated()
            .map({ index, line -> Int in
                guard
                    index >= selection.start.line && index <= selection.end.line,
                    let line = line as? String,
                    let result = regex.firstMatch(in: line, options: .reportProgress, range: .init(location: 0, length: line.count))
                    else { return 0 }

                return result.range(at: 1).location
            })
            .compactMap({ $0 })
            .max()
            else { return completionHandler(nil) }

        (selection.start.line...selection.end.line).forEach { index in
            guard
                let line = invocation.buffer.lines[index] as? String,
                let result = regex.firstMatch(in: line, options: .reportProgress, range: NSRange(location: 0, length: line.count))
                else { return }

            let range = result.range(at: 2)

            guard range.location != NSNotFound
                else { return }

            let repeatCount = position - range.location + 1

            guard repeatCount != 0
                else { return }

            let whiteSpaces = String(repeating: " ", count: abs(repeatCount))
            if repeatCount > 0 {
                invocation.buffer.lines.replaceObject(
                    at: index,
                    with: line.replacingOccurrences(of: "=", with: "\(whiteSpaces)=")
                )
            } else {
                invocation.buffer.lines.replaceObject(
                    at: index,
                    with: line.replacingOccurrences(of: "\(whiteSpaces)=", with: "=")
                )
            }
        }

        completionHandler(nil)
    }
}
