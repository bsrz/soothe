import Foundation
import XcodeKit

class AlignSourceEditorCommand: NSObject, XCSourceEditorCommand {

    // [@bsarrazin] Jun 11, 2020
    // Credit for this extension goes to https://github.com/tid-kijyun/XcodeSourceEditorExtension-Alignment
    // I have simply modified the code to make it more readable and more accurate.
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
            let userInfo = [NSLocalizedDescriptionKey: "This extension only works with a selection."]
            let error = NSError(domain: "\(#file) -> \(#function)", code: #line, userInfo: userInfo)
            return completionHandler(error)
        }
        
        var regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: "[^+^%^*^^^<^>^&^|^?^=^-](\\s*)(=)[^=]", options: .caseInsensitive)
        } catch _ {
            return completionHandler(NSError(domain: "SampleExtension", code: -1, userInfo: [NSLocalizedDescriptionKey: ""]))
        }
        
        let alignPosition = invocation.buffer.lines
            .enumerated()
            .map { i, line -> Int in
                guard
                    i >= selection.start.line && i <= selection.end.line,
                    let line = line as? String,
                    let result = regex?.firstMatch(in: line, options: .reportProgress, range: NSRange(location: 0, length: line.count))
                    else { return 0 }

                return result.range(at: 1).location
            }
            .max()

        guard let position = alignPosition
            else { return completionHandler(nil) }

        for index in selection.start.line ... selection.end.line {
            guard
                let line = invocation.buffer.lines[index] as? String,
                let result = regex?.firstMatch(in: line, options: .reportProgress, range: NSRange(location: 0, length: line.count))
                else { continue }
            
            let range = result.range(at: 2)
            if range.location != NSNotFound {
                let repeatCount = position - range.location + 1
                if repeatCount != 0 {
                    let whiteSpaces = String(repeating: " ", count: abs(repeatCount))
                    if repeatCount > 0 {
                        invocation.buffer.lines.replaceObject(at: index, with: line.replacingOccurrences(of: "=", with: "\(whiteSpaces)="))
                    } else {
                        invocation.buffer.lines.replaceObject(at: index, with: line.replacingOccurrences(of: "\(whiteSpaces)=", with: "="))
                    }
                }
            }
        }
        
        completionHandler(nil)
    }
    
}
